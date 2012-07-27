/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              KeyManage.java

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

public class KeyManage extends JFrame implements ActionListener, WindowListener{
	
	static ACR122Loader acr122 = new ACR122Loader();
	
	static int retCode;
	boolean connActive; 
	static int [] hReader = new int[1]; 
	static byte [] SendBuff = new byte[255];
	static byte [] RecvBuff = new byte[255];
	static byte [] Buffer = new byte[255];
	static int [] RecvLen = new int[1];
	static int SendLen = 0;
	
	static MifareInit Mifare;
	static SAMInit SAM;
	
	static javax.swing.JTextArea mMsg;
    private java.awt.Button bClear;
    private java.awt.Button bConn;
    private java.awt.Button bGenKeys;
    private java.awt.Button bICCon;
    private java.awt.Button bInitSAM;
    private java.awt.Button bQuit;
    private java.awt.Button bReset;
    static javax.swing.JComboBox cbPort;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JPanel mainPanel;
	
    public KeyManage() {
    	
    	this.setTitle("Get ATR");
        initComponents();
        initMenu();
    }
    
    public void initMenu()
	{
    	connActive = false;
    	bConn.setEnabled(true);
        bICCon.setEnabled(false);
        bInitSAM.setEnabled(false);
        bGenKeys.setEnabled(false);
        bReset.setEnabled(false);

	    displayOut(0, 0, "Program Ready");
		
	
	}
       
    public void actionPerformed(ActionEvent e) {
    	
    	int tempInt, pVal;
    	byte [] tempstr = new byte[255];
    	int  [] FWLEN = new int[1];
    	char tempChar;
		String tmpStr = "", tmpHex = "";
    	
		if(bConn == e.getSource())
		{
			String port = (String)cbPort.getSelectedItem();
			
			retCode = acr122.jACR122_Open(port, hReader);
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Connection to " + port + " success");
				connActive = true;
				bConn.setEnabled(false);
				bICCon.setEnabled(true);
				bReset.setEnabled(true);
				
				retCode = acr122.jACS122_GetFirmwareVersion(hReader, 0, tempstr, FWLEN);
				
				if(retCode == 0)
				{
					
					for(int i = 0; i < FWLEN[0]; i++)
					{
									
						tempInt = Integer.parseInt(Integer.toHexString(((Byte)tempstr[i]).intValue() & 0xFF).toUpperCase(), 16);
						
						tempChar = (char) tempInt;
						
						tmpStr += tempChar;
						
					}
							
					displayOut( 0, 0, "Firmware Version: " + tmpStr);
							
				}
				else
				{
					displayOut( 1, 0, "Connection to " + port + " failed");
				}				
			}
			else
			{
				displayOut( 1, 0, "Connection to " + port + " failed");
			}
			
		}
		
		if(bICCon == e.getSource())
		{
			clearBuffers();
			
			RecvLen[0] = 255;
			
			retCode = acr122.jACR122_PowerOnIcc(hReader, 0, RecvBuff, RecvLen);
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Power on ICC success");
				
				bInitSAM.setEnabled(true);
		        bGenKeys.setEnabled(true);
				
				tmpStr = "ATR: ";
				
				for(int i =0; i<RecvLen[0]; i++)
				{
					
					tmpHex = Integer.toHexString(((Byte)RecvBuff[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					tmpStr += " " + tmpHex;  
					
				}
				
				displayOut( 0, 0, tmpStr);
					
			}
			
		}
    	
    	if(bGenKeys == e.getSource())
    	{
    		if(Mifare == null)
    		{
    			Mifare = new MifareInit();
    			Mifare.addWindowListener(this);
    			Mifare.setVisible(true);
    		}
    		
    	}
    	
    	if(bInitSAM == e.getSource())
    	{
    		if(SAM == null)
    		{
    			SAM = new SAMInit();
    			SAM.addWindowListener(this);
    			SAM.setVisible(true);
    		}
    	}
    	
    	if(bClear == e.getSource())
    	{
    		mMsg.setText("");
    	}
    	
    	if(bReset == e.getSource())
		{
			
			mMsg.setText("");
			
			if(connActive == true)
			{
				acr122.jACR122_Close(hReader);
			}
			
			initMenu();
		}
    	
    	if(bQuit == e.getSource())
		{
			if(connActive == true)
			{
				acr122.jACR122_Close(hReader);
			}
			this.dispose();		
		}
    	
    }
    
    @SuppressWarnings("unchecked")
    
    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	mainPanel = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        cbPort = new javax.swing.JComboBox();
        bICCon = new java.awt.Button();
        bConn = new java.awt.Button();
        bGenKeys = new java.awt.Button();
        bClear = new java.awt.Button();
        bReset = new java.awt.Button();
        bInitSAM = new java.awt.Button();
        bQuit = new java.awt.Button();
        jScrollPane1 = new javax.swing.JScrollPane();
        mMsg = new javax.swing.JTextArea();
        
        setSize(630, 328);
        
        //sets the location of the form at the center of screen
		Dimension dim = getToolkit().getScreenSize();
		Rectangle abounds = getBounds();
		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
		requestFocus();

        mainPanel.setName("mainPanel"); 

        jLabel1.setText("Select Port:"); 
        jLabel1.setName("jLabel1"); 

        cbPort.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10" }));
        cbPort.setName("cbPort"); 

        bICCon.setLabel("Power On ICC"); 
        bICCon.setName("bICCon"); 

        bConn.setLabel("Connect"); 
        bConn.setName("bConn"); 

        bGenKeys.setLabel("Generate Keys"); 
        bGenKeys.setName("bGenKeys"); 

        bClear.setLabel("Clear"); 
        bClear.setName("bClear"); 

        bReset.setLabel("Reset"); 
        bReset.setName("bReset"); 

        bInitSAM.setLabel("Initialize SAM"); 
        bInitSAM.setName("bInitSAM"); 

        bQuit.setLabel("Quit"); 
        bQuit.setName("bQuit"); 

        jScrollPane1.setName("jScrollPane1"); 

        mMsg.setColumns(20);
        mMsg.setRows(5);
        mMsg.setName("Msg"); 
        jScrollPane1.setViewportView(mMsg);

        javax.swing.GroupLayout mainPanelLayout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(bQuit, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bReset, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bClear, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bGenKeys, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bInitSAM, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bICCon, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(bConn, javax.swing.GroupLayout.PREFERRED_SIZE, 121, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(18, 18, 18)
                        .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 397, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(12, Short.MAX_VALUE))
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 271, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, mainPanelLayout.createSequentialGroup()
                        .addGroup(mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1)
                            .addComponent(cbPort, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(bConn, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)
                        .addComponent(bICCon, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)
                        .addComponent(bInitSAM, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)
                        .addComponent(bGenKeys, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(1, 1, 1)
                        .addComponent(bClear, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)
                        .addComponent(bReset, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(1, 1, 1)
                        .addComponent(bQuit, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        
        
       bConn.addActionListener(this);
       bICCon.addActionListener(this);
       bInitSAM.addActionListener(this);
       bGenKeys.addActionListener(this);
       bClear.addActionListener(this);
       bReset.addActionListener(this);
       bQuit.addActionListener(this);
       
       
    }
    
	public static void displayOut(int mType, int msgCode, String printText)
	{
		switch(mType)
		{
		
			case 1: mMsg.append("! " + printText + "\n"); break;
			case 2: mMsg.append("< " + printText + "\n");break;
			case 3: mMsg.append("> " + printText + "\n");break;
			default: mMsg.append("- " + printText + "\n");
		
		}
		
	}
	
	public static void clearBuffers()
	{
		
		for(int i=0; i<255; i++)
		{
			
			SendBuff[i]=(byte) 0x00;
			RecvBuff[i]= (byte) 0x00;
			
		}
		
	}
	
	public static int sendAPDUandDisplay(int type)
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
		
		if(type != 0)
			retCode = acr122.jACR122_ExchangeApdu(hReader, 0, SendBuff, SendLen, RecvBuff, RecvLen);
		else
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
                new KeyManage().setVisible(true);
            }
        });
    }

	@Override
	public void windowActivated(WindowEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void windowClosed(WindowEvent e) {
				
	}

	@Override
	public void windowClosing(WindowEvent e) {
		// TODO Auto-generated method stub

		
		if(SAM == e.getSource())
		{
			SAM = null;
		}
		
		if(Mifare == e.getSource())
		{
			Mifare = null;
		}
		
	}

	@Override
	public void windowDeactivated(WindowEvent arg0) {
		// TODO Auto-generated method stub
				
	}

	@Override
	public void windowDeiconified(WindowEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowIconified(WindowEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void windowOpened(WindowEvent arg0) {
		// TODO Auto-generated method stub
		
	}

}
