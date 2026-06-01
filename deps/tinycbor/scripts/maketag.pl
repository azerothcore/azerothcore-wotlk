#!perl
use strict;
sub run(@) {
    open PROC, "-|", @_ or die("Cannot run $_[0]: $!");
    my @out;
    while (<PROC>) {
        chomp;
        push @out, $_;
    }
    close PROC;
    return @out;
}

my @tags = run("git", "tag");
my @v = run("git", "show", "HEAD:VERSION");
my $v = $v[0];

my $tagfile = ".git/TAG_EDITMSG";
open TAGFILE, ">", $tagfile
    or die("Cannot create file for editing tag message: $!");
select TAGFILE;
print "TinyCBOR release $v\n";
print "\n";
print "# Write something nice about this release here\n";

# Do we have a commit template?
my @result = run("git", "config", "--get", "commit.template");
if (scalar @result) {
    open TEMPLATE, "<", $result[0];
    map { print $_; } <TEMPLATE>;
    close TEMPLATE;
}

print "\n";
print "# Commit log\n";
open LOG, "-|", "git", "shortlog", "-e", "--no-merges", "--not", @tags;
map { print "#  $_"; } <LOG>;
close LOG;

print "# Header diff:\n";
open DIFF, "-|", "git", "diff", "HEAD", "--not", @tags, "--", 'src/*.h', ':!*_p.h';
map { print "# $_"; } <DIFF>;
close DIFF;

select STDOUT;
close TAGFILE;

# Run the editor.
# We use system so that stdin, stdout and stderr are forwarded.
@result = run("git", "var", "GIT_EDITOR");
@result = ($result[0], $tagfile);
system @result;
exit ($? >> 8) if $?;

# Create the tag
# Also using system so that hte user can see the output.
system("git", "tag", "-a", "-F", $tagfile, split(' ', $ENV{GITTAGFLAGS}), "v$v");
exit ($? >> 8) if $?;

# Update the version files for the next patch release
@v = split(/\./, $v);
if (scalar @v < 3) {
    push @v, '1';
} else {
    ++$v[-1];
}
$v = join('.', @v);
open VERSION, ">", "VERSION" or die("Cannot open VERSION file: $!");
print VERSION "$v\n";
close VERSION;

open VERSION, ">", "src/tinycbor-version.h" or die("Cannot open src/tinycbor-version.h: $!");
print VERSION "#define TINYCBOR_VERSION_MAJOR      ", $v[0], "\n";
print VERSION "#define TINYCBOR_VERSION_MINOR      ", $v[1], "\n";
print VERSION "#define TINYCBOR_VERSION_PATCH      ", $v[2], "\n";
close VERSION;

if (open APPVEYORYML, "<", ".appveyor.yml") {
    my @contents = map {
        s/^version:.*/version: $v[0].$v[1].$v[2]-build-{build}/;
        $_;
    } <APPVEYORYML>;
    close APPVEYORYML;
    open APPVEYORYML, ">", ".appveyor.yml";
    print APPVEYORYML join('', @contents);
    close APPVEYORYML;
}

# Print summary
print "Tag created and next versions updated.\n";
print "Don't forget to create the docs.\n" if $v[2] == 1;
