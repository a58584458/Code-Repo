/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              PICCCard.java

  Description:       This sample program outlines the steps on how to
                     use the SAM and Mifare Cards in ACR122S

  Author:            Alain Benedict Chua

  Date:              Nov 11, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/

import ACR122.*;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class PICCCardProg extends JFrame implements ActionListener{

	static ACR122Loader acr122 = new ACR122Loader();
	
	int retCode;
	boolean connActive; 
	
	int [] hReader = new int[1]; 
	int [] RecvLen = new int[1];
	int SendLen = 0;
	byte [] SendBuff = new byte[255];
	byte [] RecvBuff = new byte[255];
	String PrintText = new String();
	String tmpData = new String();
	
    private Button bClear;
    private Button bConn;
    private Button bQuit;
    private Button bReset;
    private Button bSend;
    private JComboBox cbPort;
    private JLabel jLabel1;
    private JLabel jLabel2;
    private JPanel jPanel1;
    private JScrollPane jScrollPane1;
    private JTextArea Msg;
    private JPanel mainPanel;
    private JTextField tData;
	
	
    public PICCCardProg() {
    	
    	this.setTitle("Other PICC Cards");
        initComponents();
        initMenu();
    }
    
    private void initComponents() {
    	
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	setSize(580,300);
    	
    	//sets the location of the form at the center of screen
   		Dimension dim = getToolkit().getScreenSize();
   		Rectangle abounds = getBounds();
   		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
   		requestFocus();
   		
    	mainPanel = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        cbPort = new javax.swing.JComboBox();
        bConn = new java.awt.Button();
        jPanel1 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        tData = new javax.swing.JTextField();
        bSend = new java.awt.Button();
        jScrollPane1 = new javax.swing.JScrollPane();
        Msg = new javax.swing.JTextArea();
        bClear = new java.awt.Button();
        bReset = new java.awt.Button();
        bQuit = new java.awt.Button();

        mainPanel.setName("mainPanel"); 

        
        jLabel1.setText("Select Port:"); 
        jLabel1.setName("jLabel1"); 

        cbPort.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10"}));
        cbPort.setName("cbPort"); 

        bConn.setLabel("Connect"); 
        bConn.setName("bConn"); 

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(""));
        jPanel1.setName("jPanel1"); 

        jLabel2.setText("Command"); 
        jLabel2.setName("jLabel2"); 

        tData.setText(""); 
        tData.setName("tData"); 

        bSend.setLabel("Send Command"); 
        bSend.setName("bSend"); 

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel2)
                .addContainerGap())
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(tData, javax.swing.GroupLayout.DEFAULT_SIZE, 239, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(bSend, javax.swing.GroupLayout.PREFERRED_SIZE, 120, javax.swing.GroupLayout.PREFERRED_SIZE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel2)
                .addGap(11, 11, 11)
                .addComponent(tData, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bSend, javax.swing.GroupLayout.DEFAULT_SIZE, 35, Short.MAX_VALUE)
                .addContainerGap())
        );

        jScrollPane1.setName("jScrollPane1"); 

        Msg.setColumns(20);
        Msg.setRows(5);
        Msg.setName("Msg"); 
        jScrollPane1.setViewportView(Msg);

        bClear.setLabel("Clear"); 
        bClear.setName("bClear"); 

        bReset.setLabel("Reset"); 
        bReset.setName("bReset"); 

        bQuit.setLabel("Quit"); 
        bQuit.setName("bQuit"); 

        javax.swing.GroupLayout mainPanelLayout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(bConn, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(10, 10, 10)
                        .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, 107, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addComponent(bClear, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(bReset, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(25, 25, 25)
                        .addComponent(bQuit, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 283, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        mainPanelLayout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {bClear, bQuit, bReset});

        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1)
                            .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(2, 2, 2)
                        .addComponent(bConn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 190, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(bClear, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bQuit, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bReset, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        
        bConn.addActionListener(this);
        bReset.addActionListener(this);
        bClear.addActionListener(this);
        bQuit.addActionListener(this);
        bSend.addActionListener(this);
        
    }
    
    public void initMenu(){
    	bReset.setEnabled(false);
    	bConn.setEnabled(true);
    	bSend.setEnabled(false);
    	
    	displayOut( 0, 0, "Program Ready");
    	
    }
	
	public void actionPerformed(ActionEvent e) {
		
		if(bConn == e.getSource())
		{
			String port = (String)cbPort.getSelectedItem();
			
			retCode = acr122.jACR122_Open(port, hReader);
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Connection to " + port + " success");
				connActive = true;
				bConn.setEnabled(false);
				bSend.setEnabled(true);
				bReset.setEnabled(true);
			}
			else
			{
				displayOut( 0, 0, "Connection to " + port + " failed");
			}
			
		}
		
		if(bSend == e.getSource())
		{
			tmpData = trimInput(0, tData.getText().trim());
			tmpData = trimInput(1, tmpData);
			
			SendLen = 0;
			RecvLen[0] = 255;
			
			for(int i = 0; i < tmpData.length() / 2; i++)
			{
				
				SendBuff[i]=(byte)((Integer)Integer.parseInt(tmpData.substring(((i*2)),((i*2)+2)), 16)).byteValue();
				SendLen++;
			}
			
			retCode = sendAPDUandDisplay();
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Send Command Success");
			}
			else
			{
				displayOut( 0, 0, "Send Command Failed");
			}
			
			
		}
		
		if(bReset == e.getSource())
		{		
			Msg.setText("");
			tData.setText("");
			
			if(connActive == true)
			{
				acr122.jACR122_Close(hReader);
			}

			initMenu();
				
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
	
	public String trimInput(int trimType, String strIn)
	{
		
		String tmpStr="";
		
		strIn = strIn.trim();
		
		switch(trimType)
		{
		
		case 0:
		{
			for (int i=0; i<strIn.length(); i++)
				if((strIn.charAt(i)!=(char)13)&&(strIn.charAt(i)!=(char)10))
					tmpStr = tmpStr + strIn.charAt(i);
			break;
		}
		
		case 1:
			for(int i=0; i<strIn.length(); i++)
				if (strIn.charAt(i)!=(char)32)
					tmpStr = tmpStr + strIn.charAt(i);
		
		}
		
		return tmpStr;
		
	}
	
	public int sendAPDUandDisplay()
	{
		String tmpStr = "", tmpHex="";
		
		for(int i =0; i< SendLen; i++)
		{
			
			tmpHex = Integer.toHexString(((Byte)SendBuff[i]).intValue() & 0xFF).toUpperCase();

			//For single character hex
			if (tmpHex.length() == 1) 
				tmpHex = "0" + tmpHex;
			
			tmpStr += " " + tmpHex;  
			
		}
		
		displayOut(3, 0, tmpStr);
		
		retCode = acr122.jACR122_DirectTransmit(hReader, SendBuff, SendLen, RecvBuff, RecvLen);
		
		if(retCode == 0)
		{
			tmpStr = "";
			
			for(int i =0; i<RecvLen[0]; i++)
			{
				
				tmpHex = Integer.toHexString(((Byte)RecvBuff[i]).intValue() & 0xFF).toUpperCase();
				
				//For single character hex
				if (tmpHex.length() == 1) 
					tmpHex = "0" + tmpHex;
				
				tmpStr += " " + tmpHex;  
				
			}
			
			displayOut( 2, 0, tmpStr);
			
			
		}
		else
		{
			return 1;
		}
		
	
		return retCode;
	}
	
    public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new PICCCardProg().setVisible(true);
            }
        });
    }

}
