Auth
	account
		id					- >	ID
		username			- >	Username
		salt				- >	Salt
		verifier			- >	Verifier
		session_key			- >	SessionKey
		totp_secret			- >	TOTPSecret
		email				- >	Email
		reg_mail			- >	RegMail
		joindate			- >	JoinDate
		last_ip				- >	LastIP
		last_attempt_ip		- >	LastAttemptIP
		failed_logins		- >	FailedLogins
		locked				- >	Locked
		lock_country		- >	LockCountry
		last_login			- >	LastLogin
		online				- >	Online
		expansion			- >	Expansion
		mutetime			- >	MuteTime
		mutereason			- >	MuteReason
		muteby				- >	MutedBy
		locale				- >	Locale
		os					- >	OS
		recruiter			- >	Recruiter
		localtime			- >	LocalTime
	account_access
		id					- >	ID
		gmlevel				- >	GMLevel
		RealmID				- >	RealmID
		comment				- >	Comment
	account_banned
		id					- >	ID
		bandate				- >	BanDate
		unbandate			- >	UnbanDate
		bannedby			- >	BannedBy
		banreason			- >	BanReason
		active				- >	Active
	account_muted
		guid				- >	GUID
		mutedate			- >	MuteDate
		mutetime			- >	MuteTime
		mutedby				- >	MutedBy
		mutereason			- >	MuteReason
	autobroadcast		- >	auto_broadcast
		realmid				- >	RealmID
		id					- >	ID
		weight				- >	Weight
		text				- >	Text
	build_info
		build				- >	Build
		majorVersion		- >	MajorVersion
		minorVersion		- >	MinorVersion
		bugfixVersion		- >	BugfixVersion
		hotfixVersion		- >	HotfixVersion
		winAuthSeed			- >	WinAuthSeed
		win64AuthSeed		- >	Win64AuthSeed
		mac64AuthSeed		- >	Mac64AuthSeed
		winChecksumSeed		- >	WinChecksumSeed
		macChecksumSeed		- >	MacChecksumSeed
	ip_banned
		ip					- >	IP
		bandate				- >	BanDate
		unbandate			- >	UnbanDate
		bannedby			- >	BannedBy
		banreason			- >	BanReason
	logs
		time				- >	Time
		realm				- >	Realm
		type				- >	Type
		level				- >	Level
		string				- >	String
	logs_ip_actions
		id					- >	ID
		account_id			- >	AccountID
		character_guid		- >	CharacterGUID
		type				- >	Type
		ip					- >	IP
		systemnote			- >	SystemNote
		unixtime			- >	UnixTime
		time				- >	Time
		comment				- >	Comment
	realmcharacters		- >	realm_characters
		realmid				- >	RealmID
		acctid				- >	AccountID
		numchars			- >	NumChars
	realmlist
		id					- >	ID
		name				- >	Name
		address				- >	Address
		localAddress		- >	LocalAddress
		localSubnetMask		- >	LocalSubnetMask
		port				- >	Port
		icon				- >	Icon
		flag				- >	Flag
		timezone			- >	Timezone
		allowedSecurityLevel- >	AllowedSecurityLevel
		population			- >	Population
		gamebuild			- >	Build
	secret_digest
		id					- >	ID
		digest				- >	Digest
	updates
		name				- >	Name
		hash				- >	Hash
		state				- >	State
		timestamp			- >	Timestamp
		speed				- >	Duration
	updates_include
		path				- >	Path
		state				- >	State
	uptime
		realmid				- >	RealmID
		starttime			- >	StartTime
		uptime				- >	Uptime
		maxplayers			- >	MaxPlayers
		revision			- >	Revision