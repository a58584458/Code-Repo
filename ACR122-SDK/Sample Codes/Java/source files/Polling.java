/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              DeviceProgramming.java

  Description:       This sample program outlines the steps on how to
                     poll PICC cards in ACR122S

  Author:            Alain Benedict Chua

  Date:              Nov 11, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/

import ACR122.*;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class Polling extends JFrame implements ActionListener{
	
	static ACR122Loader acr122 = new ACR122Loader();
	
	int retCode;
	boolean connActive;
	boolean enablePoll;
	
	int [] hReader = new int[1]; 
	int [] RecvLen = new int[1];
	int SendLen = 0;
	byte [] SendBuff = new byte[255];
	byte [] RecvBuff = new byte[255];
	String PrintText = new String();
	String tmpData = new String();
	Timer timer;
	
	private java.awt.Button bConn;
    private java.awt.Button bQuit;
    private java.awt.Button bStart;
    private javax.swing.JComboBox cbPort;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel lCard;
    private javax.swing.JLabel lCardType;
    private javax.swing.JPanel mainPanel;
	
    public Polling() {
    	
    	this.setTitle("Other PICC Cards");
        initComponents();
        initMenu();
    }
    
    private void initComponents() {
    	
    		
    	 Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
       	 this.setIconImage(icon);
    	
    	 setSize(240, 241);
    	
    	//sets the location of the form at the center of screen
		Dimension dim = getToolkit().getScreenSize();
		Rectangle abounds = getBounds();
		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
		requestFocus();
    		
    	 mainPanel = new javax.swing.JPanel();
         jLabel1 = new javax.swing.JLabel();
         cbPort = new javax.swing.JComboBox();
         bConn = new java.awt.Button();
         bStart = new java.awt.Button();
         bQuit = new java.awt.Button();
         lCard = new javax.swing.JLabel();
         lCardType = new javax.swing.JLabel();

         mainPanel.setName("mainPanel"); 

         
         jLabel1.setText("Select Port:"); 
         jLabel1.setName("jLabel1"); 

         cbPort.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10" }));
         cbPort.setName("cbPort"); 

         bConn.setLabel("Connect"); 
         bConn.setName("bConn"); 

         bStart.setLabel("Start Polling"); 
         bStart.setName("bStart"); 

         bQuit.setLabel("Quit"); 
         bQuit.setName("bQuit"); 

         lCard.setText("Card Type:"); 
         lCard.setName("lCard"); 

         lCardType.setText(""); 
         lCardType.setName("lCardType"); 

         javax.swing.GroupLayout mainPanelLayout = new javax.swing.GroupLayout(getContentPane());
         getContentPane().setLayout(mainPanelLayout);
         mainPanelLayout.setHorizontalGroup(
             mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
             .addGroup(mainPanelLayout.createSequentialGroup()
                 .addContainerGap()
                 .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                     .addGroup(mainPanelLayout.createSequentialGroup()
                         .addComponent(jLabel1)
                         .addGap(18, 18, 18)
                         .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE))
                     .addComponent(bQuit, javax.swing.GroupLayout.DEFAULT_SIZE, 210, Short.MAX_VALUE)
                     .addComponent(bStart, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                     .addGroup(mainPanelLayout.createSequentialGroup()
                         .addComponent(lCard)
                         .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                         .addComponent(lCardType, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE))
                     .addComponent(bConn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                 .addContainerGap(14, Short.MAX_VALUE))
         );
         mainPanelLayout.setVerticalGroup(
             mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
             .addGroup(mainPanelLayout.createSequentialGroup()
                 .addContainerGap()
                 .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                     .addComponent(jLabel1)
                     .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                 .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                 .addComponent(bConn, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                 .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                 .addComponent(bStart, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                 .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                 .addComponent(bQuit, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                 .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                 .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                     .addComponent(lCard)
                     .addComponent(lCardType))
                 .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
         );

         mainPanelLayout.linkSize(javax.swing.SwingConstants.VERTICAL, new java.awt.Component[] {bConn, bQuit, bStart});
         
         bConn.addActionListener(this);
         bStart.addActionListener(this);
         bQuit.addActionListener(this);
    }
    
    public void initMenu(){

    	bConn.setEnabled(true);
    	bStart.setEnabled(false);
    	
    	enablePoll = false;
    	
    	timer = new Timer(1000, this);
    	
    }
    
    public void actionPerformed(ActionEvent e) {
    	
    	if(bConn == e.getSource())
		{
			String port = (String)cbPort.getSelectedItem();
			
			retCode = acr122.jACR122_Open(port, hReader);
			
			if(retCode == 0)
			{
				connActive = true;
				bConn.setEnabled(false);
				bStart.setEnabled(true);
				
				JOptionPane.showMessageDialog( null, "Connection Success");
			}
			else
			{
				JOptionPane.showMessageDialog( null, "Connection Failed");
			}
			
		}
    	
    	if(bStart == e.getSource())
    	{
    		if(enablePoll == false)
    		{
    		   enablePoll = true;
    		   bStart.setLabel("Stop Polling");
    		   timer.start();
    		}
    		else
    		{
    		   enablePoll = false;
    		   bStart.setLabel("Start Polling");
    		   lCardType.setText("");
			   timer.stop();
					
    		}
    		
    	}
    	
    	if(timer == e.getSource())
    	{
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
					
					lCardType.setText(PrintText);
				}
				else
				{
					lCardType.setText("");
				}
							
			}
    		
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
    
    
    
    public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Polling().setVisible(true);
            }
        });
    }
	

}
