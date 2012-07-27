import sys
import socket
import string

###### FUNCTIONS #####
def msg_handler_privmsg(privmsg):
    net_ident = msg_parts[0]
    chan = msg_parts[2]
    msg = msg_parts[3]
    
    if msg==':!fib':
        value = int(msg_parts[4]) if str.isdigit(msg_parts[4]) else 0
        fib_seq = str(fib(value))
        s.send("PRIVMSG %s :%s \r\n" % (chan, fib_seq))
    
    return

def msg_handler_ping(msg):
    s.send("PONG %s\r\n" % msg[1])
    return

def fib(n):
    seq = "0 "
    a, b = 0, 1
    while b < n:
        seq = seq + str(b) +" "
        a, b = b, a+b
        
    return seq
#######################

#######################
## BEGIN MAIN THREAD ##
HOST="irc.efnet.net"
PORT=6667
NICK="MyNickName"
IDENT="My Nick Name"
REALNAME="Real Name"
readbuffer=""

f = open('./irc_log', 'w')

s=socket.socket( )
s.connect((HOST, PORT))
s.send("NICK %s\r\n" % NICK)
s.send("USER %s %s bla :%s\r\n" % (IDENT, HOST, REALNAME))
s.send("JOIN #MyChannel \r\n");
s.send("JOIN #AnotherChan \r\n");

while 1:
    readbuffer=readbuffer+s.recv(1024)
    temp=string.split(readbuffer, "\n")
    readbuffer=temp.pop( )

    for line in temp:
        print "::> "+ line
        f.write("::> "+ line +"\n")
        
        line=string.rstrip(line)

        msg_parts = line.split(" ")
        print(msg_parts)
        
        if msg_parts[1] == 'PRIVMSG':
            msg_handler_privmsg(msg_parts)
        elif msg_parts[0] == 'PING':
            msg_handler_ping(msg_parts)
