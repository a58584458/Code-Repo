/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              GetATR.java

  Description:       This sample program outlines the steps on how to
                     get ATR from cards using ACR122s

  Author:            Alain Benedict Chua

  Date:              Oct 20, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/

import ACR122.*;

import java.awt.*;
import java.awt.event.*;
import java.awt.image.ImageObserver;
import java.awt.image.ImageProducer;

import javax.swing.*;



public class GetATR extends JFrame implements ActionListener{

	static ACR122Loader acr122 = new ACR122Loader();
	
	//JPCSC Variables
	int retCode;
	boolean connActive; 
	
	//All variables that requires pass-by-reference calls to functions are
	//declared as 'Array of int' with length 1
	//Java does not process pass-by-ref to int-type variables, thus Array of int was used.
	int [] hReader = new int[1]; 
	int [] RecvLen = new int[1];
	int SendLen = 0;
	byte [] SendBuff = new byte[255];
	byte [] RecvBuff = new byte[255];
	String PrintText = new String();
	String tmpStr    = new String();
	
	//GUI Variables
	private JButton bClear, bConn, bGetATR, bReset, bQuit;
    private JLabel lblReader;
    private JPanel menuPanel, msgPanel, readerpanel;
    private JTextArea Msg;
    private JScrollPane msgScrollPane;
    private JComboBox cbPort;

    

    public GetATR() {
    	
    	this.setTitle("Get ATR");
        initComponents();
        initMenu();
    }

    private void initComponents() {

    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
   		setSize(700,400);
   		
   		//sets the location of the form at the center of screen
   		Dimension dim = getToolkit().getScreenSize();
   		Rectangle abounds = getBounds();
   		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
   		requestFocus();
   		
   		readerpanel = new JPanel();
        lblReader = new JLabel();
        bConn = new JButton();
        bGetATR = new JButton();
        menuPanel = new JPanel();
        bClear = new JButton();
        bReset = new JButton();
        msgPanel = new JPanel();
        msgScrollPane = new JScrollPane();
        Msg = new JTextArea();
        bQuit = new JButton();
        
        lblReader.setText("Select Port:");

        String[] cbPortDef = {"COM1"};	
		cbPort = new JComboBox(cbPortDef);
		cbPort.setSelectedIndex(0);
		
		for(int i = 2; i <= 10; i++)		
			cbPort.addItem("COM" + i);

        bConn.setText("Connect");

        bGetATR.setText("Get ATR");

        javax.swing.GroupLayout readerpanelLayout = new javax.swing.GroupLayout(readerpanel);
        readerpanel.setLayout(readerpanelLayout);
        readerpanelLayout.setHorizontalGroup(
            readerpanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(readerpanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(readerpanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, readerpanelLayout.createSequentialGroup()
                        .addComponent(lblReader)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cbPort, 0, 175, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, readerpanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(bGetATR, javax.swing.GroupLayout.Alignment.TRAILING, 120, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(bConn, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        readerpanelLayout.setVerticalGroup(
            readerpanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(readerpanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(readerpanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblReader)
                    .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bConn)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bGetATR)
                .addContainerGap(18, Short.MAX_VALUE))
        );

        bReset.setText("Reset");

        bQuit.setText("Quit");

        bClear.setText("Clear Screen");

        javax.swing.GroupLayout menuPanelLayout = new javax.swing.GroupLayout(menuPanel);
        menuPanel.setLayout(menuPanelLayout);
        menuPanelLayout.setHorizontalGroup(
            menuPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(menuPanelLayout.createSequentialGroup()
                .addGroup(menuPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, menuPanelLayout.createSequentialGroup()
                        .addContainerGap(132, Short.MAX_VALUE)
                        .addGroup(menuPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(bClear, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(bReset, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 124, Short.MAX_VALUE)
                            .addComponent(bQuit, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 124, Short.MAX_VALUE)))))
        );
        menuPanelLayout.setVerticalGroup(
            menuPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, menuPanelLayout.createSequentialGroup()
                .addContainerGap(27, Short.MAX_VALUE)
                .addComponent(bClear)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bReset)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bQuit)
                .addContainerGap())
        );

        Msg.setColumns(20);
        Msg.setRows(5);
        msgScrollPane.setViewportView(Msg);

        javax.swing.GroupLayout msgPanelLayout = new javax.swing.GroupLayout(msgPanel);
        msgPanel.setLayout(msgPanelLayout);
        msgPanelLayout.setHorizontalGroup(
            msgPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(msgScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 272, Short.MAX_VALUE)
        );
        msgPanelLayout.setVerticalGroup(
            msgPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(msgScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 273, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(menuPanel, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(readerpanel, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(msgPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(msgPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(readerpanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(menuPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        
        bConn.addActionListener(this);
        bGetATR.addActionListener(this);
        bClear.addActionListener(this);
        bReset.addActionListener(this);
        bQuit.addActionListener(this);
        
    }

    public void actionPerformed(ActionEvent e) {
    	
		if (bReset == e.getSource()) 
		{
			if(connActive)
			{
				acr122.jACR122_Close(hReader);
			}
			
			Msg.setText("");
			initMenu();
			
		}
		

		
		if(bConn == e.getSource())
		{
			String port = (String)cbPort.getSelectedItem();
			
			retCode = acr122.jACR122_Open(port, hReader);
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Connection to " + port + " success");
				connActive = true;
				bConn.setEnabled(false);
				bReset.setEnabled(true);
				bGetATR.setEnabled(true);
			}
			else
			{
				displayOut( 0, 0, "Connection to " + port + " failed");
			}
			
		}
		
		if(bGetATR == e.getSource())
		{
			PrintText = "";
			
			SendBuff[0] = (byte) 0xD4;
			SendBuff[1] = (byte) 0x60;
			SendBuff[2] = (byte) 0x01;
			SendBuff[3] = (byte) 0x01;
			SendBuff[4] = (byte) 0x20;
			SendBuff[5] = (byte) 0x23;
			SendBuff[6] = (byte) 0x11;
			SendBuff[7] = (byte) 0x04;
			SendBuff[8] = (byte) 0x10;
			
			SendLen = 9;
			RecvLen[0] = 255;
			
			retCode = acr122.jACR122_DirectTransmit(hReader, SendBuff, SendLen, RecvBuff, RecvLen);
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "ATR");
				for(int i = 0; i < RecvLen[0] - 1; i++)
				{
					tmpStr = Integer.toHexString(((Byte)RecvBuff[i]) & 0xFF).toUpperCase();
					
					if(tmpStr.length() == 1)
						tmpStr = "0" + tmpStr;
					
					PrintText = PrintText + tmpStr + " ";  
					
					
				}
				
				displayOut( 0, 0, PrintText);
				
				if(RecvLen[0] > 3)
				{
					switch(RecvBuff[8])
					{
					case (byte) 0x18: PrintText = "Mifare 4K"; break;
					case (byte) 0x00: PrintText = "Mifare Ultralight";  break;
					case (byte) 0x28: PrintText = "ISO 14443-4 Type A"; break;
					case (byte) 0x08: PrintText = "Mifare 1K"; break;
					case (byte) 0x09: PrintText = "Mifare Mini"; break;
					case (byte) 0x20: PrintText = "Mifare DesFire"; break;
					case (byte) 0x98: PrintText = "GemPlus MPCOS"; break;
					default:
							switch(RecvBuff[3])
							{
							case (byte) 0x23: PrintText = "ISO 14443-4 Type B"; break;
							case (byte) 0x11: PrintText = "FeliCa 212K"; break;
							case (byte) 0x04: PrintText = "Topaz"; break;
							default:
								PrintText = "Unknown contactless card"; 
							}
					}
					
					displayOut( 0, 0, PrintText);
				}
				else
				{
					displayOut( 0, 0, "No contactless card detected");
				}
				
				
			}
			
		  
		}
		
		if (bClear == e.getSource())
		{
	
			Msg.setText("");
			
		}
		
		if(bQuit == e.getSource())
		{
			if(connActive)
			{
				acr122.jACR122_Close(hReader);
			}
			
			this.dispose();
			
		}
    }
    
	public void displayOut(int mType, int msgCode, String printText)
	{

		switch(mType)
		{
		
			case 1: 
				{
					
					Msg.append("! " + printText);
					//Msg.append(ACSModule.GetScardErrMsg(msgCode) + "\n");
					break;
					
				}
			case 2: Msg.append("< " + printText + "\n");break;
			case 3: Msg.append("> " + printText + "\n");break;
			default: Msg.append("- " + printText + "\n");
		
		}
		
	}
	
	
	public void initMenu()
	{
	
		connActive = false;
		bConn.setEnabled(true);
		bGetATR.setEnabled(false);
		bReset.setEnabled(false);
		displayOut(0, 0, "Program Ready");
		
	}
	
    public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new GetATR().setVisible(true);
            }
        });
    }



}
