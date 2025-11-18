<?php
// Bypass ngrok warning once PHP runs
header('ngrok-skip-browser-warning: true');

header('Content-Type: application/json; charset=utf-8');
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
if ($method !== 'POST') {
  http_response_code(405);
  echo json_encode(['ok'=>false,'error'=>'Use POST']); exit;
}

// --- tiny IP rate limit: 5 req per minute ---
$ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
$bucketDir = sys_get_temp_dir() . '/reg_rl';
if (!is_dir($bucketDir)) @mkdir($bucketDir, 0777, true);
$bucket = $bucketDir . '/' . preg_replace('/[^0-9a-fA-F:\.]/', '_', $ip);
$hits = 0; $now = time();
if (file_exists($bucket)) {
  $data = @json_decode(@file_get_contents($bucket), true) ?: ['t'=>$now,'n'=>0];
  if ($now - ($data['t']??0) > 60) { $data = ['t'=>$now,'n'=>0]; }
  $data['n'] = (int)$data['n'] + 1; $hits = $data['n'];
  @file_put_contents($bucket, json_encode($data));
} else {
  @file_put_contents($bucket, json_encode(['t'=>$now,'n'=>1]));
  $hits = 1;
}
if ($hits > 5) { http_response_code(429); echo json_encode(['ok'=>false,'error'=>'Too many requests']); exit; }

// --- read env / config ---
$dbHost = getenv('DB_HOST') ?: 'ac-database';
$dbPort = (int)(getenv('DB_PORT') ?: 3306);
$dbName = getenv('DB_NAME') ?: 'acore_auth';
$dbUser = getenv('DB_USER') ?: 'webreg';
$dbPass = getenv('DB_PASS') ?: 'CHANGE_ME_STRONG';
$defaultExpansion = (int)(getenv('DEFAULT_EXPANSION') ?: 2);

// --- input ---
// --- input validation ---
$input = $_POST;
$username = trim($input['username'] ?? '');
$password = (string)($input['password'] ?? '');
$email    = trim($input['email'] ?? '');

if ($username === '' || $password === '') {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'username and password required']); exit;
}

// Validação rigorosa do username
if (strlen($username) < 3) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'username must be at least 3 characters']); exit;
}
if (strlen($username) > 20) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'username max 20 chars']); exit;
}

// Bloquear caracteres perigosos no username
if (!preg_match('/^[a-zA-Z][a-zA-Z0-9_]*$/', $username)) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'username can only contain letters, numbers and underscore, and must start with a letter']); exit;
}

// Bloquear caracteres de SQL injection
if (preg_match('/[@%\'"`;\\\\<>{}\[\]\(\)\|&\$\*\+\?\^=!~`]/', $username)) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'username contains forbidden characters']); exit;
}

// Validação da senha
if (strlen($password) < 6) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'password must be at least 6 characters']); exit;
}

// Bloquear caracteres perigosos na senha
if (preg_match('/[\'"`;\\\\<>{}\[\]\|&\$]/', $password)) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'password contains forbidden characters']); exit;
}

// Validação do email se fornecido
if ($email !== '' && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
  http_response_code(400); echo json_encode(['ok'=>false,'error'=>'invalid email format']); exit;
}

// Sanitização adicional (mesmo com prepared statements, é uma boa prática)
$username = preg_replace('/[^a-zA-Z0-9_]/', '', $username);
$email = filter_var($email, FILTER_SANITIZE_EMAIL);
if (!function_exists('gmp_powm')) {
  http_response_code(500); echo json_encode(['ok'=>false,'error'=>'GMP extension not enabled']); exit;
}

// --- SRP6 helpers ---
function gen_salt32(): string { return random_bytes(32); }
function srp6_verifier(string $u, string $p, string $saltBytes): string {
  $g = gmp_init(7);
  $N = gmp_init('894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7', 16);
  $h1 = sha1(strtoupper($u).':'.strtoupper($p), true);
  $h2 = sha1($saltBytes.$h1, true);
  $x  = gmp_init(bin2hex(strrev($h2)), 16);            // little-endian -> big-endian hex
  $v  = gmp_powm($g, $x, $N);
  $hex = gmp_strval($v, 16);
  if (strlen($hex) % 2) $hex = '0'.$hex;
  $v_be = hex2bin(str_pad($hex, 64, '0', STR_PAD_LEFT));
  return strrev($v_be);                                 // 32 bytes little-endian
}

// --- connect DB ---
try {
  $dsn = "mysql:host=$dbHost;port=$dbPort;dbname=$dbName;charset=utf8mb4";
  $pdo = new PDO($dsn, $dbUser, $dbPass, [
    PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
  ]);

  // exists?
  $st = $pdo->prepare('SELECT 1 FROM account WHERE username = ?');
  $st->execute([$username]);
  if ($st->fetch()) {
    http_response_code(409); echo json_encode(['ok'=>false,'error'=>'usuario já existe peixe']); exit;
  }

  $salt = gen_salt32();
  $ver  = srp6_verifier($username, $password, $salt);

  $sql = 'INSERT INTO account
          (username, salt, verifier, email, reg_mail, joindate, last_ip, last_attempt_ip, failed_logins, locked, lock_country, online, expansion, Flags, mutetime, mutereason, muteby, locale, os, recruiter, totaltime)
          VALUES
          (:u, :s, :v, :e, :e, NOW(), "127.0.0.1", "127.0.0.1", 0, 0, "00", 0, :exp, 0, 0, "", "", 0, "", 0, 0)';
  $ins = $pdo->prepare($sql);
  $ins->bindValue(':u', $username);
  $ins->bindValue(':s', $salt, PDO::PARAM_LOB);
  $ins->bindValue(':v', $ver,  PDO::PARAM_LOB);
  $ins->bindValue(':e', $email);
  $ins->bindValue(':exp', $defaultExpansion, PDO::PARAM_INT);
  $ins->execute();

  echo json_encode(['ok'=>true,'message'=>'account created']);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok'=>false,'error'=>$e->getMessage()]);
}
