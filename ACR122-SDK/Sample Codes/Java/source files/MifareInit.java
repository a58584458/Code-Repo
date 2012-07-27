/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              MifareInit.java

  Description:       This sample program outlines the steps on how to
                     use the SAM and Mifare Cards in ACR122S

  Author:            Alain Benedict Chua

  Date:              Nov 11, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/

import ACR122.*;

import java.awt.Dimension;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.*;


public class MifareInit extends JFrame implements ActionListener, KeyListener{
	
	static String VALIDCHARS = "0123456789abcdefABCDEF";
	
	byte [] UID = new byte[255];
	int retCode;
	
	private java.awt.Button bCancel;
	private java.awt.Button bGenKeys;
    private java.awt.Button bSaveKeys;
    private JCheckBox cb1, cb2, cb3, cb4, cb5, cb6;
    private JLabel jLabel1, jLabel2, jLabel3, jLabel4, jLabel5, jLabel6;
    private JLabel jLabel7, jLabel8, jLabel9;
    private JPanel jPanel1, jPanel2;
    private JPanel mainPanel;
    private JRadioButton rbA;
    private JRadioButton rbB;
    private JTextField tb1, tb2, tb3, tb4, tb5, tb6;
    private JTextField tbIC;
    private JTextField tbKc;
    private JTextField tbKcf;
    private JTextField tbKcr;
    private JTextField tbKd;
    private JTextField tbKrd;
    private JTextField tbKt;
    private JTextField tbSerial;
	
    public MifareInit() {
    	this.setTitle("Generate Keys for Mifare");
        initComponents();
        initMenu();
    }
    
    public void initMenu(){
    	
    	rbA.setSelected(true);
    }
    
    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	setSize(550, 420);
    	
    	//sets the location of the form at the center of screen
		Dimension dim = getToolkit().getScreenSize();
		Rectangle abounds = getBounds();
		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
		requestFocus();
    	
    	mainPanel = new JPanel();
        jPanel1 = new JPanel();
        jLabel1 = new JLabel();
        jLabel2 = new JLabel();
        jLabel3 = new JLabel();
        jLabel4 = new JLabel();
        jLabel5 = new JLabel();
        jLabel6 = new JLabel();
        jLabel7 = new JLabel();
        jLabel8 = new JLabel();
        tbSerial = new JTextField();
        tbIC = new JTextField();
        tbKc = new JTextField();
        tbKt = new JTextField();
        tbKd = new JTextField();
        tbKcr = new JTextField();
        tbKcf = new JTextField();
        tbKrd = new JTextField();
        bGenKeys = new java.awt.Button();
        jPanel2 = new JPanel();
        jLabel9 = new JLabel();
        rbA = new JRadioButton();
        rbB = new JRadioButton();
        cb1 = new JCheckBox();
        cb2 = new JCheckBox();
        cb3 = new JCheckBox();
        cb4 = new JCheckBox();
        cb5 = new JCheckBox();
        cb6 = new JCheckBox();
        tb1 = new JTextField();
        tb2 = new JTextField();
        tb3 = new JTextField();
        tb4 = new JTextField();
        tb5 = new JTextField();
        tb6 = new JTextField();
        bSaveKeys = new java.awt.Button();
        bCancel = new java.awt.Button();

        mainPanel.setName("mainPanel"); 

        jPanel1.setBorder(BorderFactory.createTitledBorder("Generate Keys")); 
        jPanel1.setName("jPanel1"); 

        jLabel1.setText("Card Serial Number:"); 
        jLabel1.setName("jLabel1"); 

        jLabel2.setText("Issuer Code (IC):"); 
        jLabel2.setName("jLabel2"); 

        jLabel3.setText("Card Key (Kc):"); 
        jLabel3.setName("jLabel3"); 

        jLabel4.setText("Terminal Key (Kt):"); 
        jLabel4.setName("jLabel4"); 

        jLabel5.setText("Debit Key (Kd):"); 
        jLabel5.setName("jLabel5"); 

        jLabel6.setText("Credit Key (Kcr):"); 
        jLabel6.setName("jLabel6"); 

        jLabel7.setText("Certify Key (Kcf):"); 
        jLabel7.setName("jLabel7"); 

        jLabel8.setText("Revoke Debit Key (Krd):"); 
        jLabel8.setName("jLabel8"); 

        tbSerial.setText(""); 
        tbSerial.setName("tbSerial"); 

        tbIC.setText(""); 
        tbIC.setName("tbIC"); 

        tbKc.setText(""); 
        tbKc.setName("tbKc"); 

        tbKt.setText(""); 
        tbKt.setName("tbKt"); 

        tbKd.setText(""); 
        tbKd.setName("tbKd"); 

        tbKcr.setText(""); 
        tbKcr.setName("tbKcr"); 

        tbKcf.setText(""); 
        tbKcf.setName("tbKcf"); 

        tbKrd.setText(""); 
        tbKrd.setName("tbKrd"); 

        bGenKeys.setLabel("Generate Keys"); 
        bGenKeys.setName("bGenKeys"); 

        GroupLayout jPanel1Layout = new GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING, false)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbSerial, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel2)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbIC, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel3)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbKc, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel4)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbKt, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel5)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbKd, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel6)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(tbKcr, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel8)
                                    .addComponent(jLabel7))
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(tbKrd, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tbKcf, GroupLayout.PREFERRED_SIZE, 125, GroupLayout.PREFERRED_SIZE)))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(78, 78, 78)
                        .addComponent(bGenKeys, GroupLayout.PREFERRED_SIZE, 110, GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(16, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addComponent(tbSerial, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(tbIC, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(tbKc, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(tbKt, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(tbKd, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(tbKcr, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(tbKcf, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addGap(8, 8, 8)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel8)
                    .addComponent(tbKrd, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bGenKeys, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(11, Short.MAX_VALUE))
        );

        jPanel2.setBorder(BorderFactory.createTitledBorder("Save Keys")); 
        jPanel2.setName("jPanel2"); 

        jLabel9.setText("Save as:"); 
        jLabel9.setName("jLabel9"); 

        rbA.setText("Key Type A"); 
        rbA.setName("rbA"); 

        rbB.setText("Key Type B"); 
        rbB.setName("rbB"); 

        cb1.setText("Save to sector no:");
        cb1.setName("cb1"); 

        cb2.setText("Save to sector no:");
        cb2.setName("cb2"); 

        cb3.setText("Save to sector no:");
        cb3.setName("cb3"); 

        cb4.setText("Save to sector no:");
        cb4.setName("cb4"); 

        cb5.setText("Save to sector no:");
        cb5.setName("cb5"); 

        cb6.setText("Save to sector no:");
        cb6.setName("cb6"); 

        tb1.setText(""); 
        tb1.setName("tb1"); 

        tb2.setText(""); 
        tb2.setName("tb2"); 

        tb3.setText(""); 
        tb3.setName("tb3"); 

        tb4.setText(""); 
        tb4.setName("tb4"); 

        tb5.setText(""); 
        tb5.setName("tb5"); 

        tb6.setText(""); 
        tb6.setName("tb6"); 

        bSaveKeys.setLabel("Save Keys"); 
        bSaveKeys.setName("bSaveKeys"); 

        GroupLayout jPanel2Layout = new GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel9)
                            .addGroup(GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb3, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb4, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb5, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                     .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addComponent(cb6, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED))
                                    )
                                .addGap(10, 10, 10)
                                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(tb5, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tb6, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tb4, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tb1, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tb2, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tb3, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)))
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(10, 10, 10)
                                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                                    .addComponent(rbB)
                                    .addComponent(rbA)))))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(39, 39, 39)
                        .addComponent(bSaveKeys, GroupLayout.PREFERRED_SIZE, 110, GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(16, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)                   
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel9)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(rbA)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(rbB)
                        .addGap(10, 10, 10)
                        ))
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb3, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb3, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb4, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb4, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb5, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb5, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(cb6, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(tb6, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addGap(30, 30, 30))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bSaveKeys, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
                )
        );

        bCancel.setLabel("Cancel"); 
        bCancel.setName("bCancel"); 

        GroupLayout mainPanelLayout = new GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(14, Short.MAX_VALUE))
            .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                .addContainerGap(214, Short.MAX_VALUE)
                .addComponent(bCancel, GroupLayout.PREFERRED_SIZE, 138, GroupLayout.PREFERRED_SIZE)
                .addGap(175, 175, 175))
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                    .addComponent(jPanel2, GroupLayout.Alignment.LEADING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel1, GroupLayout.Alignment.LEADING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bCancel, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
                )
        );
    	
        tb1.addKeyListener(this);
        tb2.addKeyListener(this);
        tb3.addKeyListener(this);
        tb4.addKeyListener(this);
        tb5.addKeyListener(this);
        tb6.addKeyListener(this);
        
        tbSerial.setEditable(false);
        tbIC.setEditable(false);
        tbKc.setEditable(false);
        tbKt.setEditable(false);
        tbKcr.setEditable(false);
        tbKd.setEditable(false);
        tbKcf.setEditable(false);
        tbKrd.setEditable(false);
        
        bGenKeys.addActionListener(this);
        bSaveKeys.addActionListener(this);
        bCancel.addActionListener(this);
        
        rbA.addActionListener(this);
        rbB.addActionListener(this);
              
    }
    
    
	public void actionPerformed(ActionEvent e) {
		
		if(bGenKeys == e.getSource())
		{
			String serial = "";
			String key = "";
			String tmpHex = "";
			
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0xD4;
			KeyManage.SendBuff[1] = (byte) 0x4A;
			KeyManage.SendBuff[2] = (byte) 0x01;
			KeyManage.SendBuff[3] = (byte) 0x00;
			
			KeyManage.SendLen = 4;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(0);
			
			if(retCode != 0)
			{
				KeyManage.displayOut( 1, 0, "Failed to get card serial number");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				for(int i = 8; i < KeyManage.RecvBuff[7] + 8; i++)
				{
					UID[i - 8] = KeyManage.RecvBuff[i];
				}
				
				for(int i = 0; i < 4; i++)
				{
					tmpHex = Integer.toHexString(((Byte)UID[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					serial += tmpHex + " "; 
				}
				
				tbSerial.setText(serial);
				
			}
			
			//Select Issuer DF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xA4;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x02;
			KeyManage.SendBuff[5] = (byte) 0x11;
			KeyManage.SendBuff[6] = (byte) 0x00;
			
			KeyManage.SendLen = 7;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0)
			{
				KeyManage.displayOut( 1, 0, "Failed to select issuer DF");
				this.dispose();
				KeyManage.Mifare = null;
			}
			
			//Submit Issuer PIN
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0x20;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x01;
			KeyManage.SendBuff[4] = (byte) 0x08;
			
			for(int i = 0; i < 8; i++)
			{
				KeyManage.SendBuff[i + 5] = KeyManage.Buffer[i];
			}
			
			KeyManage.SendLen = 13;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0)
			{
				KeyManage.displayOut( 1, 0, "Failed to submit issuer PIN");
				this.dispose();
				KeyManage.Mifare = null;
			}
			
			//Generate Key
			//Generate IC Using 1st SAM Master Key (KeyID=81)
			key = GenerateSAMKey((byte) 0x81);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain IC Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbIC.setText(key);
			}
			
			//Generate Card Key Using 2nd SAM Master Key (KeyID=82)  
			key = GenerateSAMKey((byte) 0x82);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Card Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKc.setText(key);
			}
			
			//Generate Terminal Key Using 3rd SAM Master Key (KeyID=83) 
			key = GenerateSAMKey((byte) 0x83);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Terminal Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKt.setText(key);
			}
			
			//Generate Debit Key Using 4th SAM Master Key (KeyID=84)
			key = GenerateSAMKey((byte) 0x84);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Debit Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKd.setText(key);
			}
			
			//Generate Credit Key Using 5th SAM Master Key (KeyID=85)
			key = GenerateSAMKey((byte) 0x85);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Credit Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKcr.setText(key);
			}
			
			//Generate Certify Key Using 6th SAM Master Key (KeyID=86)   
			key = GenerateSAMKey((byte) 0x86);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Certify Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKcf.setText(key);
			}
			
			//Generate Revoke Debit Key Using 7th SAM Master Key (KeyID=87) 
			key = GenerateSAMKey((byte) 0x87);
			if(key.equals("") == true)
			{
				KeyManage.displayOut( 1, 0, "Failed to obtain Revoke Debit Key");
				this.dispose();
				KeyManage.Mifare = null;
			}
			else
			{
				tbKrd.setText(key);
			}
	
		}
		
		if(bSaveKeys == e.getSource())
		{
			
			retCode = JOptionPane.showConfirmDialog( null, "Saving keys to Mifare assumes that the keys stored is \"FF FF FF FF FF FF\". Continue?", "Warning", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
			
			if(retCode == JOptionPane.NO_OPTION)
				return;
			
			if(cb1.isSelected())
			{
				if(tbKc.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Card Key generated");
					return;
				}
				
				if(tb1.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb1.requestFocus();
					return;
				}
				
			}
			
			if(cb2.isSelected())
			{
				if(tbKt.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Terminal Key generated");
					return;
				}
				
				if(tb2.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb2.requestFocus();
					return;
				}
				
			}
			
			if(cb3.isSelected())
			{
				if(tbKd.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Debit Key generated");
					return;
				}
				
				if(tb3.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb3.requestFocus();
					return;
				}
				
			}
			
			if(cb4.isSelected())
			{
				if(tbKcr.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Credit Key generated");
					return;
				}
				
				if(tb4.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb4.requestFocus();
					return;
				}
				
			}
			
			if(cb5.isSelected())
			{
				if(tbKcf.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Certify Key generated");
					return;
				}
				
				if(tb5.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb5.requestFocus();
					return;
				}
				
			}
			
			if(cb6.isSelected())
			{
				if(tbKrd.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "No Revoke Debit Key generated");
					return;
				}
				
				if(tb6.getText().equals(""))
				{
					JOptionPane.showMessageDialog( null, "Enter Valid value for block number");
					tb6.requestFocus();
					return;
				}
				
			}
			
			if(cb1.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb1.getText(), 16)).byteValue(), 1);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			if(cb2.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb2.getText(), 16)).byteValue(), 2);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			if(cb3.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb3.getText(), 16)).byteValue(), 3);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			if(cb4.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb4.getText(), 16)).byteValue(), 4);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			if(cb5.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb5.getText(), 16)).byteValue(), 5);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			if(cb6.isSelected())
			{
				retCode = SaveKey(((Integer)Integer.parseInt(tb6.getText(), 16)).byteValue(), 6);
				
				if(retCode != 0)
				{
					return;
				}
			}
			
			KeyManage.displayOut( 1, 0, "Save keys success");
			this.dispose();
			KeyManage.Mifare = null;
			
		}
		
		if(bCancel == e.getSource())
		{
			this.dispose();
			KeyManage.Mifare = null;
		}
		
		if(rbA == e.getSource())
		{
			rbA.setSelected(true);
			rbB.setSelected(false);
		}
		
		if(rbB == e.getSource())
		{
			rbA.setSelected(false);
			rbB.setSelected(true);
		}
		
	}

	public int SaveKey(int BlockNo, int keytype){
		
		byte [] temp = new byte[255];
		byte [] keyin = new byte[255];
		String tmpStr = "";
		
		BlockNo = BlockNo * 4  + 3;
		
		KeyManage.clearBuffers();
		KeyManage.SendBuff[0] = (byte) 0xD4;
		KeyManage.SendBuff[1] = (byte) 0x40;
		KeyManage.SendBuff[2] = (byte) 0x01;
		KeyManage.SendBuff[3] = (byte) 0x60;
		KeyManage.SendBuff[4] = (byte) BlockNo;
		KeyManage.SendBuff[5] = (byte) 0xFF;
		KeyManage.SendBuff[6] = (byte) 0xFF;
		KeyManage.SendBuff[7] = (byte) 0xFF;
		KeyManage.SendBuff[8] = (byte) 0xFF;
		KeyManage.SendBuff[9] = (byte) 0xFF;
		KeyManage.SendBuff[10] = (byte) 0xFF;
		
		KeyManage.SendBuff[11] = UID[0];
		KeyManage.SendBuff[12] = UID[1];
		KeyManage.SendBuff[13] = UID[2];
		KeyManage.SendBuff[14] = UID[3];
		
		KeyManage.SendLen = 15;
		KeyManage.RecvLen[0] = 255;
		
		retCode = KeyManage.sendAPDUandDisplay(0);
		
		if(retCode != 0)
		{
			KeyManage.displayOut( 1, 0, "Error in generating Key");
			this.dispose();
			KeyManage.Mifare = null;
			return 1;
		}
		else
		{
			if(KeyManage.RecvBuff[2] != (byte) 0x00)
			{
				KeyManage.displayOut( 1, 0, "Error in generating Key");
				this.dispose();
				KeyManage.Mifare = null;
				return 1;	
			}
		}
		
		KeyManage.clearBuffers();
		KeyManage.SendBuff[0] = (byte) 0xD4;
		KeyManage.SendBuff[1] = (byte) 0x40;
		KeyManage.SendBuff[2] = (byte) 0x01;
		KeyManage.SendBuff[3] = (byte) 0x30;
		KeyManage.SendBuff[4] = (byte) BlockNo;
		
		KeyManage.SendLen = 5;
		KeyManage.RecvLen[0] = 255;

		retCode = KeyManage.sendAPDUandDisplay(0);
		
		if(retCode != 0)
		{
			KeyManage.displayOut( 1, 0, "Error in saving Key");
			this.dispose();
			KeyManage.Mifare = null;
			return 1;
		}
		else
		{
			if(KeyManage.RecvLen[0] < 4)
			{
				KeyManage.displayOut( 1, 0, "Error in saving Key");
				this.dispose();
				KeyManage.Mifare = null;
				return 1;
			}
			
			for(int i = 3; i < KeyManage.RecvLen[0]; i++)
			{
				temp[i - 3] = KeyManage.RecvBuff[i];
			}					
		}
		
		switch(keytype)
		{
			case 1: tmpStr = tbKc.getText(); break;
			case 2: tmpStr = tbKt.getText(); break;
			case 3: tmpStr = tbKd.getText(); break;
			case 4: tmpStr = tbKcr.getText(); break;
			case 5: tmpStr = tbKcf.getText(); break;
			case 6: tmpStr = tbKrd.getText(); break;
			default: KeyManage.displayOut( 1, 0, "Error in saving Key");
					 this.dispose();
					 KeyManage.Mifare = null;
					 return 1;	
		
		}
		
		for(int i = 0; i < tmpStr.length() / 2; i++)
		{
			keyin[i]=(byte)((Integer)Integer.parseInt(tmpStr.substring(((i*2)),((i*2)+2)), 16)).byteValue();
		}
			
		
		if(rbA.isSelected())
		{
			for(int i = 0; i < 16; i++)
			{
				if( i < 6)
				{
					KeyManage.SendBuff[i + 5] = keyin[i];
				}
				else
				{
					KeyManage.SendBuff[i + 5] = temp[i];
				}
			}
		}
		else
		{
			for(int i = 0; i < 16; i++)
			{
				if( i < 10)
				{
					KeyManage.SendBuff[i + 5] = temp[i];
				}
				else
				{
					KeyManage.SendBuff[i + 5] = keyin[i - 10];
				}
			}
		}
		
		KeyManage.SendBuff[0] = (byte) 0xD4;
		KeyManage.SendBuff[1] = (byte) 0x40;
		KeyManage.SendBuff[2] = (byte) 0x01;
		KeyManage.SendBuff[3] = (byte) 0xA0;
		KeyManage.SendBuff[4] = (byte) BlockNo;
		
		KeyManage.SendLen = 21;
		KeyManage.RecvLen[0] = 255;

		retCode = KeyManage.sendAPDUandDisplay(0);
		
		if(retCode != 0)
		{
			KeyManage.displayOut( 1, 0, "Error in saving Key");
			this.dispose();
			KeyManage.Mifare = null;
			return 1;
		}
		
		return 0;
	}
	
	public String GenerateSAMKey(byte KeyId){
		String buff = "";
		String tmpHex;
		
		KeyManage.clearBuffers();
		KeyManage.SendBuff[0] = (byte) 0x80;
		KeyManage.SendBuff[1] = (byte) 0x88;
		KeyManage.SendBuff[2] = (byte) 0x00;
		KeyManage.SendBuff[3] = KeyId;
		KeyManage.SendBuff[4] = (byte) 0x08;
		
		for(int i = 0; i < 4; i++)
			KeyManage.SendBuff[i + 5] = UID[i];
		
		KeyManage.SendLen = 13;
		KeyManage.RecvLen[0] = 255;
		
		retCode = KeyManage.sendAPDUandDisplay(1);
		
		if(retCode != 0)
		{
			KeyManage.displayOut( 1, 0, "Error in generating Key");
			this.dispose();
			KeyManage.Mifare = null;
		}
		
		KeyManage.clearBuffers();
		KeyManage.SendBuff[0] = (byte) 0x00;
		KeyManage.SendBuff[1] = (byte) 0xC0;
		KeyManage.SendBuff[2] = (byte) 0x00;
		KeyManage.SendBuff[3] = (byte) 0x00;
		KeyManage.SendBuff[4] = (byte) 0x08;
		
		KeyManage.SendLen = 5;
		KeyManage.RecvLen[0] = 255;
		
		retCode = KeyManage.sendAPDUandDisplay(1);
		
		if(retCode != 0)
		{
			KeyManage.displayOut( 1, 0, "Error in generating Key");
			this.dispose();
			KeyManage.Mifare = null;
		}
		else
		{
			if(KeyManage.RecvBuff[KeyManage.RecvLen[0] - 2] == (byte) 0x90 && KeyManage.RecvBuff[KeyManage.RecvLen[0] - 1] == (byte) 0x00)
			{
				buff = "";
				
				for(int i =0; i < 6; i++)
				{
				
					tmpHex = Integer.toHexString(((Byte)KeyManage.RecvBuff[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					buff += tmpHex;  
					
				}
			}
		}
			
		return buff;
	}
	
	public void keyReleased(KeyEvent ke) {
		
	}
	
	public void keyPressed(KeyEvent ke) {
  		//restrict paste actions
		if (ke.getKeyCode() == KeyEvent.VK_V ) 
			ke.setKeyCode(KeyEvent.VK_UNDO );						
  	}
	
	public void keyTyped(KeyEvent ke) 
	{
		Character x = (Character)ke.getKeyChar();
  		char empty = '\r';
  		

  		//Check valid characters
  		if(tb1.isFocusOwner() || 
  		   tb2.isFocusOwner() || 
  		   tb3.isFocusOwner() || 
  		   tb4.isFocusOwner() ||
  		   tb5.isFocusOwner() || 
  		   tb6.isFocusOwner())
  		{	
  		
  			if (VALIDCHARS.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);		
  		}
  		
  					  
		//Limit character length
  		if(tb1.isFocusOwner() || 
  	  	   tb2.isFocusOwner() || 
  	  	   tb3.isFocusOwner() || 
  	  	   tb4.isFocusOwner() ||
  	  	   tb5.isFocusOwner() || 
  	  	   tb6.isFocusOwner())
  		{
  			
  			if(((JTextField)ke.getSource()).getText().length() > 2 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
	}

}
