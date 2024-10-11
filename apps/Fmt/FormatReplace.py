import pathlib
from os import getcwd

if not getcwd().endswith('src') and not getcwd().endswith('modules'):
    print('Run this from the src or modules directory!')
    print('(Invoke as \'python ../apps/Fmt/FormatReplace.py\')')
    exit(1)

def isASSERT(line):
    substring = 'ASSERT'
    if substring in line:
        return True
    else :
        return False

def isABORTMSG(line):
    substring = 'ABORT_MSG'
    if substring in line:
        return True
    else :
        return False

def islog(line):
    substring = 'LOG_'
    if substring in line:
        return True
    else :
        return False

# def isSendSysMessage(line):
#     substring = 'SendSysMessage'
#     if substring in line:
#         return True
#     else :
#         return False

# def isPSendSysMessage(line):
#     substring = 'PSendSysMessage'
#     if substring in line:
#         return True
#     else :
#         return False

def isPQuery(line):
    substring = 'PQuery'
    if substring in line:
        return True
    else :
        return False

def isPExecute(line):
    substring = 'PExecute'
    if substring in line:
        return True
    else :
        return False

def isPAppend(line):
    substring = 'PAppend'
    if substring in line:
        return True
    else :
        return False

def isStringFormat(line):
    substring = 'StringFormat'
    if substring in line:
        return True
    else :
        return False

def haveDelimeter(line):
    if ';' in line:
        return True
    else :
        return False

def checkSoloLine(line):
    if isABORTMSG(line):
        line = line.replace("ABORT_MSG", "ABORT");
        return handleCleanup(line), False
    elif isASSERT(line):
        return handleCleanup(line), False
    elif islog(line):
        return handleCleanup(line), False
    elif isPExecute(line):
        line = line.replace("PExecute", "Execute");
        return handleCleanup(line), False
    elif isPQuery(line):
        line = line.replace("PQuery", "Query");
        return handleCleanup(line), False
    elif isPAppend(line):
        line = line.replace("PAppend", "Append");
        return handleCleanup(line), False
    # elif isSendSysMessage(line):
    #     return handleCleanup(line), False
    # elif isPSendSysMessage(line):
    #     return handleCleanup(line), False
    elif isStringFormat(line):
        return handleCleanup(line), False
    else:
        return line, False

def startMultiLine(line):
    if isABORTMSG(line):
        line = line.replace("ABORT_MSG", "ABORT");
        return handleCleanup(line), True
    elif isASSERT(line):
        return handleCleanup(line), True
    elif islog(line):
        return handleCleanup(line), True
    # elif isSendSysMessage(line):
    #     return handleCleanup(line), True
    # elif isPSendSysMessage(line):
    #     return handleCleanup(line), True
    elif isPQuery(line):
        line = line.replace("PQuery", "Query");
        return handleCleanup(line), True
    elif isPExecute(line):
        line = line.replace("PExecute", "Execute");
        return handleCleanup(line), True
    elif isPAppend(line):
        line = line.replace("PAppend", "Append");
        return handleCleanup(line), True
    elif isStringFormat(line):
        return handleCleanup(line), True
    else :
        return line, False

def continueMultiLine(line, existPrevLine):
    if haveDelimeter(line):
        existPrevLine = False;
    return handleCleanup(line), existPrevLine

def checkTextLine(line, existPrevLine):
    if existPrevLine:
        return continueMultiLine(line, existPrevLine)
    else :
        if haveDelimeter(line):
            return checkSoloLine(line)
        else :
            return startMultiLine(line)

def handleCleanup(line):
    line = line.replace("%s", "{}");
    line = line.replace("%u", "{}");
    line = line.replace("%hu", "{}");
    line = line.replace("%lu", "{}");
    line = line.replace("%llu", "{}");
    line = line.replace("%zu", "{}");
    line = line.replace("%02u", "{:02}");
    line = line.replace("%03u", "{:03}");
    line = line.replace("%04u", "{:04}");
    line = line.replace("%05u", "{:05}");
    line = line.replace("%02i", "{:02}");
    line = line.replace("%03i", "{:03}");
    line = line.replace("%04i", "{:04}");
    line = line.replace("%05i", "{:05}");
    line = line.replace("%02d", "{:02}");
    line = line.replace("%03d", "{:03}");
    line = line.replace("%04d", "{:04}");
    line = line.replace("%05d", "{:05}");
    line = line.replace("%d", "{}");
    line = line.replace("%i", "{}");
    line = line.replace("%x", "{:x}");
    line = line.replace("%X", "{:X}");
    line = line.replace("%lx", "{:x}");
    line = line.replace("%lX", "{:X}");
    line = line.replace("%02X", "{:02X}");
    line = line.replace("%08X", "{:08X}");
    line = line.replace("%f", "{}");
    line = line.replace("%.1f", "{0:.1f}");
    line = line.replace("%.2f", "{0:.2f}");
    line = line.replace("%.3f", "{0:.3f}");
    line = line.replace("%.4f", "{0:.4f}");
    line = line.replace("%.5f", "{0:.5f}");
    line = line.replace("%3.1f", "{:3.1f}");
    line = line.replace("%%", "%");
    line = line.replace(".c_str()", "");
    line = line.replace("\" SZFMTD \"", "{}");
    line = line.replace("\" UI64FMTD \"", "{}");
    # line = line.replace("\" STRING_VIEW_FMT \"", "{}");
    # line = line.replace("STRING_VIEW_FMT_ARG", "");
    return line

def getDefaultfile(name):
    file1 = open(name, "r+", encoding="utf8", errors='replace')

    result = ''

    while True:
        line = file1.readline()

        if not line:
            break

        result += line

    file1.close
    return result

def getModifiedfile(name):
    file1 = open(name, "r+", encoding="utf8", errors='replace')

    prevLines = False
    result = ''

    while True:
        line = file1.readline()

        if not line:
            break

        line, prevLines = checkTextLine(line, prevLines)
        result += line

    file1.close
    return result

def updModifiedfile(name, text):
    file = open(name, "w", encoding="utf8", errors='replace')
    file.write(text)
    file.close()

def handlefile(name):
    oldtext = getDefaultfile(name)
    newtext = getModifiedfile(name)

    if oldtext != newtext:
        updModifiedfile(name, newtext)

p = pathlib.Path('.')
for i in p.glob('**/*'):
    fname = i.absolute()
    if '.cpp' in i.name:
        handlefile(fname)
    if '.h' in i.name:
        handlefile(fname)
