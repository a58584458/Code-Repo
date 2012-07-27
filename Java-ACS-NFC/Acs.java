import java.io.*;
import java.awt.*;
import java.awt.event.*;

import java.util.List;

import java.math.BigInteger;
import java.lang.Integer;
import java.lang.Byte;

import javax.swing.*;
import javax.swing.filechooser.*;
import javax.swing.filechooser.FileFilter;

import javax.smartcardio.*;

public class Acs {

    public static void main (String[] args) {
        System.out.println("Hello ACS!");
        
        try {
            TerminalFactory terminalFactory = TerminalFactory.getDefault();
            System.out.println("Terminal List: "+ terminalFactory.terminals().list().toString());
            
            CardTerminal terminal = terminalFactory.terminals().list().get(0);
            System.out.println("Selected terminal: "+ terminal.toString());
            
            if (terminal.isCardPresent()){
                System.out.println("Card Available");
                
                Card card = terminal.connect("*");
                ATR atr = card.getATR();
                System.out.println("ATR: "+ atr.toString());
                
                byte[] bytes = atr.getBytes();
                //Integer bi = new BigInteger(1, bytes);
                //System.out.println(bi.toString(16));
                /*for (int i=0; i<bytes.length;i++){
                    Byte myByte = new Byte(bytes[i]);
                    System.out.println(Integer.toHexString(myByte.intValue()));
                    
                    //System.out.println(new String(new byte[] {bytes[i]}));
                    //System.out.println(String.toHexString(bytes[i].intValue()));
                }*/
                
                /*StringBuilder sb = new StringBuilder(bytes.length * 2);
                for (int i=0; i< bytes.length; i++) {
                    sb.append(String.format("%02x", bytes[i]));
                }
                
                String hex1 = sb.toString();
                System.out.println(hex1);*/
                System.out.println(Acs.bytesToHex(bytes));

                //BigInteger bi = new BigInteger(bytes);
                //String hex2 = bi.toString(16);
                
                CardChannel channel = card.getBasicChannel();
                
                byte[] readCommand = new byte[]{
                    (byte)0xFF,
                    (byte)0xB0,
                    (byte)0x00,
                    (byte)0x10,
                    (byte)0x04};
                
                //BigInteger rcbi = new BigInteger(readCommand);
                //String rchex = rcbi.toString(16);
                System.out.println(Acs.bytesToHex(readCommand));
                
                CommandAPDU command = new CommandAPDU(readCommand);
                //CommandAPDU command = new CommandAPDU(new byte[]{(byte)0x01, (byte)0x02});
                ResponseAPDU response = channel.transmit(command);
                String responseString = new String(response.getBytes());
                System.out.println("response: " + Acs.bytesToHex(response.getBytes()));
                System.out.println("response string: "+ responseString);
                
                String writeString = new String ("test");
                byte[] writeBytes = writeString.getBytes();
                
                byte[] writeCommand = new byte[]{
                    (byte)0xFF,
                    (byte)0xD6,
                    (byte)0x00,
                    (byte)0x10,
                    (byte)0x04};
                    /*(byte)0x44,
                    (byte)0x45,
                    (byte)0x52,
                    (byte)0x45};*/
                    /*(byte)0x45,
                    (byte)0x46,
                    (byte)0x47,
                    (byte)0x48,
                    (byte)0x49,
                    (byte)0x50,
                    (byte)0x51};*/
                
                //BigInteger commandbi = new BigInteger(writeCommand);
                //String hex = commandbi.toString(16);
                //System.out.println(hex);
                
                //BigInteger writebi = new BigInteger(writeBytes);
                //String hex3 = writebi.toString(16);
                //System.out.println(Acs.bytesToHex(writeBytes));
                
                byte[] writePacket = new byte[writeCommand.length + writeBytes.length];
                for (int i = 0; i < writePacket.length; ++i) {
                    writePacket[i] = i<writeCommand.length ? writeCommand[i] : writeBytes[i - writeCommand.length];
                }
                
                //BigInteger packetbi = new BigInteger(writePacket);
                //String hex4 = packetbi.toString(16);
                //System.out.println(Acs.bytesToHex(writePacket));
                
                //CommandAPDU command2 = new CommandAPDU(writeCommand);
                CommandAPDU command2 = new CommandAPDU(writePacket);
                ResponseAPDU response2 = channel.transmit(command2);
                
                //BigInteger packetr = new BigInteger(response2.getBytes());
                //String hexr = packetr.toString(16);
                //System.out.println(Acs.bytesToHex(response2.getBytes()));
                
                //String response2String = new String(response2.getBytes());
                //System.out.println("response2: " + response2String);
            } else {
                System.out.println("No card present");
            }
            
            
            //Card card = terminal.connect("*");
            //CardChannel channel = card.getBasicChannel();
    
            //ATR atr = card.getATR();
            //System.out.println("ATR: "+ atr.toString());

            // Construct a command and transmit it
            //CommandAPDU command = new CommandAPDU(new byte[]{(byte)0x01, (byte)0x02});
            //ResponseAPDU response = channel.transmit(command);
        } catch (IllegalArgumentException e){
            System.out.println("Exception: "+ e.getMessage());
        } catch (CardException e) {
            System.out.println("Exception: "+ e.getMessage());
        }
        
        /*// show the list of available terminals
        TerminalFactory factory = TerminalFactory.getDefault();
        List<CardTerminal> terminals = factory.terminals().list();
        System.out.println("Terminals: " + terminals);
        // get the first terminal
        CardTerminal terminal = terminals.get(0);
        // establish a connection with the card
        Card card = terminal.connect("T=0");
        System.out.println("card: " + card);
        CardChannel channel = card.getBasicChannel();
        ResponseAPDU r = channel.transmit(new CommandAPDU(channel));
        //ResponseAPDU r = channel.transmit(new CommandAPDU(c1));
        System.out.println("response: " + toString(r.getBytes()));
        // disconnect
        card.disconnect(false);*/
    }

    public static String bytesToHex (byte[] bytes) {
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (int i=0; i< bytes.length; i++) {
            sb.append(String.format("%02x", bytes[i]));
        }
                
        return sb.toString();
    }
}
