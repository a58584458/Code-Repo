/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              SAMMinit.java

  Description:       This sample program outlines the steps on how to
                     use other PICC Cards in ACR122S

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
import java.awt.event.WindowEvent;


import javax.swing.*;


public class SAMInit extends JFrame implements ActionListener, KeyListener{
	
	static String VALIDCHARS = "0123456789abcdefABCDEF";
	
	int retCode;
	
	private java.awt.Button bInitSAM;
    private java.awt.Button bCancel;
    private JLabel jLabel1;
    private JLabel jLabel2;
    private JLabel jLabel3;
    private JLabel jLabel4;
    private JLabel jLabel5;
    private JLabel jLabel6;
    private JLabel jLabel7;
    private JLabel jLabel8;
    private JPanel jPanel1;
    private JTextField tbGlobal;
    private JTextField tbIssuer;
    private JTextField tbCard;
    private JTextField tbTerm;
    private JTextField tbDebit;
    private JTextField tbCredit;
    private JTextField tbCert;
    private JTextField tbRevoke;
    private JPanel mainPanel;
	

	public SAMInit() {
    	this.setTitle("Initialize SAM");
        initComponents();
        initMenu();
        

    }
    
    public void initMenu(){
    	
    }
    
    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	setSize(360, 335);
    	
    	//sets the location of the form at the center of screen
		Dimension dim = getToolkit().getScreenSize();
		Rectangle abounds = getBounds();
		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
		requestFocus();
    	
    	mainPanel = new JPanel();
        jPanel1 = new JPanel();
        jLabel1 = new JLabel();
        tbGlobal = new JTextField();
        jLabel2 = new JLabel();
        jLabel3 = new JLabel();
        jLabel4 = new JLabel();
        jLabel5 = new JLabel();
        jLabel6 = new JLabel();
        jLabel7 = new JLabel();
        jLabel8 = new JLabel();
        tbIssuer = new JTextField();
        tbCard = new JTextField();
        tbTerm = new JTextField();
        tbDebit = new JTextField();
        tbCredit = new JTextField();
        tbCert = new JTextField();
        tbRevoke = new JTextField();
        bInitSAM = new java.awt.Button();
        bCancel = new java.awt.Button();

        mainPanel.setName("mainPanel"); 

        
        jPanel1.setBorder(BorderFactory.createTitledBorder("Initialize SAM")); 
        jPanel1.setName("jPanel1"); 

        jLabel1.setText("SAM Global PIN:"); 
        jLabel1.setName("jLabel1"); 

        tbGlobal.setText(""); 
        tbGlobal.setName("tbGlobal"); 

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

        jLabel8.setText("RevokeDebit Key (Krd)"); 
        jLabel8.setName("jLabel8"); 

        tbIssuer.setText(""); 
        tbIssuer.setName("tbIssuer"); 

        tbCard.setText(""); 
        tbCard.setName("tbCard"); 

        tbTerm.setText(""); 
        tbTerm.setName("tbTerm"); 

        tbDebit.setText(""); 
        tbDebit.setName("tbDebit"); 

        tbCredit.setText(""); 
        tbCredit.setName("tbCredit"); 

        tbCert.setText(""); 
        tbCert.setName("tbCert"); 

        tbRevoke.setText(""); 
        tbRevoke.setName("tbRevoke"); 

        bCancel.setLabel("Cancel"); 
        bCancel.setName("bCancel"); 

        bInitSAM.setLabel("Initialize SAM"); 
        bInitSAM.setName("bInitSAM"); 

        GroupLayout jPanel1Layout = new GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbGlobal, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbIssuer, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbCard, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbDebit, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbCert, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel1)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel2)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel3)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel4)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel5)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel6)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel7)
                .addContainerGap(10, Short.MAX_VALUE))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(jLabel8)
                .addContainerGap(10, Short.MAX_VALUE))                    
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbRevoke, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbCredit, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(GroupLayout.Alignment.CENTER, jPanel1Layout.createSequentialGroup()
                .addGap(136, 136, 136)
                .addComponent(tbTerm, GroupLayout.PREFERRED_SIZE, 165, GroupLayout.PREFERRED_SIZE)
                .addGap(282, 282, 282))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(29, 29, 29)
                .addComponent(bInitSAM, GroupLayout.PREFERRED_SIZE, 86, GroupLayout.PREFERRED_SIZE)
                .addGap(41, 41, 41)
                .addComponent(bCancel, GroupLayout.PREFERRED_SIZE, 86, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(341, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(tbGlobal, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addGap(21, 21, 21)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel2)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tbIssuer, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(tbCard, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(tbTerm, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel4))))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(tbDebit, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel5))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(tbCredit, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(tbCert, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel7))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel8)
                    .addComponent(tbRevoke, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(bCancel, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
                    .addComponent(bInitSAM, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE))
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        GroupLayout mainPanelLayout = new GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, 333, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        
        tbGlobal.addKeyListener(this);
        tbIssuer.addKeyListener(this);
        tbCard.addKeyListener(this);
        tbTerm.addKeyListener(this);
        tbDebit.addKeyListener(this);
        tbCredit.addKeyListener(this);
        tbCert.addKeyListener(this);
        tbRevoke.addKeyListener(this);
        
        bCancel.addActionListener(this);
        bInitSAM.addActionListener(this);
        
    }
    
	public void actionPerformed(ActionEvent e) {
		
		if(bInitSAM == e.getSource())
		{
			if(tbGlobal.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Global PIN");
				tbGlobal.requestFocus();
				return;
			}
			
			if(tbIssuer.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Issuer Code");
				tbIssuer.requestFocus();
				return;
			}
			
			if(tbCard.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Card Key");
				tbCard.requestFocus();
				return;
			}
			
			if(tbTerm.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Terminal Key");
				tbTerm.requestFocus();
				return;
			}
			
			if(tbDebit.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Debit Key");
				tbDebit.requestFocus();
				return;
			}
			
			if(tbCredit.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Credit Key");
				tbCredit.requestFocus();
				return;
			}
			
			if(tbCert.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Certify Key");
				tbCert.requestFocus();
				return;
			}
			
			if(tbRevoke.getText().length() < 16)
			{
				JOptionPane.showMessageDialog( null, "Please enter 8 bytes of keys for Revoke Debit Key");
				tbRevoke.requestFocus();
				return;
			}
			
			KeyManage.clearBuffers();
			//Clear Card
			KeyManage.SendBuff[0] = (byte) 0x80;
			KeyManage.SendBuff[1] = (byte) 0x30;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x00;
			
			KeyManage.SendLen = 5;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode == 0)
			{
				KeyManage.displayOut( 0, 0, "Clear SAM success");
			}
			else
			{
				KeyManage.displayOut( 1, 0, "Clear SAM failed");
				this.dispose();
				KeyManage.SAM = null;			
			}
			
			//Reset SAM
			retCode = KeyManage.acr122.jACR122_PowerOffIcc(KeyManage.hReader, 0);
			retCode = KeyManage.acr122.jACR122_Close(KeyManage.hReader);
			retCode = KeyManage.acr122.jACR122_Open((String)KeyManage.cbPort.getSelectedItem() , KeyManage.hReader);
			KeyManage.RecvLen[0] = 255;
			retCode = KeyManage.acr122.jACR122_PowerOnIcc( KeyManage.hReader, 0, KeyManage.RecvBuff, KeyManage.RecvLen);
			
			if(retCode == 0)
			{
				KeyManage.displayOut( 0, 0, "Reset success");
			}
			else
			{
				KeyManage.displayOut( 1, 0, "Reset failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.clearBuffers();
			//Create Master File
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE0;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x0F;
			KeyManage.SendBuff[5] = (byte) 0x62;
			KeyManage.SendBuff[6] = (byte) 0x0D;
			KeyManage.SendBuff[7] = (byte) 0x82;
			KeyManage.SendBuff[8] = (byte) 0x01;
			KeyManage.SendBuff[9] = (byte) 0x3F;
			KeyManage.SendBuff[10] = (byte) 0x83;
			KeyManage.SendBuff[11] = (byte) 0x02;
			KeyManage.SendBuff[12] = (byte) 0x3F;
			KeyManage.SendBuff[13] = (byte) 0x00;
			KeyManage.SendBuff[14] = (byte) 0x8A;
			KeyManage.SendBuff[15] = (byte) 0x01;
			KeyManage.SendBuff[16] = (byte) 0x01;
			KeyManage.SendBuff[17] = (byte) 0x8C;
			KeyManage.SendBuff[18] = (byte) 0x01;
			KeyManage.SendBuff[19] = (byte) 0x00;
			
			KeyManage.SendLen = 20;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Creating master file failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.clearBuffers();
			//Create EF1 to Store PIN
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE0;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x1B;
			KeyManage.SendBuff[5] = (byte) 0x62;
			KeyManage.SendBuff[6] = (byte) 0x19;
			KeyManage.SendBuff[7] = (byte) 0x83;
			KeyManage.SendBuff[8] = (byte) 0x02;
			KeyManage.SendBuff[9] = (byte) 0xFF;
			KeyManage.SendBuff[10] = (byte) 0x0A;
			KeyManage.SendBuff[11] = (byte) 0x88;
			KeyManage.SendBuff[12] = (byte) 0x01;
			KeyManage.SendBuff[13] = (byte) 0x01;
			KeyManage.SendBuff[14] = (byte) 0x82;
			KeyManage.SendBuff[15] = (byte) 0x06;
			KeyManage.SendBuff[16] = (byte) 0x0C;
			KeyManage.SendBuff[17] = (byte) 0x00;
			KeyManage.SendBuff[18] = (byte) 0x00;
			KeyManage.SendBuff[19] = (byte) 0x0A;
			KeyManage.SendBuff[20] = (byte) 0x00;
			KeyManage.SendBuff[21] = (byte) 0x01;
			KeyManage.SendBuff[22] = (byte) 0x8C;
			KeyManage.SendBuff[23] = (byte) 0x08;
			KeyManage.SendBuff[24] = (byte) 0x7F;
			KeyManage.SendBuff[25] = (byte) 0xFF;
			KeyManage.SendBuff[26] = (byte) 0xFF;
			KeyManage.SendBuff[27] = (byte) 0xFF;
			KeyManage.SendBuff[28] = (byte) 0xFF;
			KeyManage.SendBuff[29] = (byte) 0x27;
			KeyManage.SendBuff[30] = (byte) 0x27;
			KeyManage.SendBuff[31] = (byte) 0xFF;

			KeyManage.SendLen = 32;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Creating EF1 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.clearBuffers();
			//Set Global PIN
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xDC;
			KeyManage.SendBuff[2] = (byte) 0x01;
			KeyManage.SendBuff[3] = (byte) 0x04;
			KeyManage.SendBuff[4] = (byte) 0x0A;
			KeyManage.SendBuff[5] = (byte) 0x01;
			KeyManage.SendBuff[6] = (byte) 0x88;
			
			for(int i = 0; i < tbGlobal.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 7]=(byte)((Integer)Integer.parseInt(tbGlobal.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 15;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0)
			{
				KeyManage.displayOut( 1, 0, "Setting Global PIN failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.clearBuffers();
			//Create DF
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE0;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x2B;
			KeyManage.SendBuff[5] = (byte) 0x62;
			KeyManage.SendBuff[6] = (byte) 0x29;
			KeyManage.SendBuff[7] = (byte) 0x82;
			KeyManage.SendBuff[8] = (byte) 0x01;
			KeyManage.SendBuff[9] = (byte) 0x38;
			KeyManage.SendBuff[10] = (byte) 0x83;
			KeyManage.SendBuff[11] = (byte) 0x02;
			KeyManage.SendBuff[12] = (byte) 0x11;
			KeyManage.SendBuff[13] = (byte) 0x00;
			KeyManage.SendBuff[14] = (byte) 0x8A;
			KeyManage.SendBuff[15] = (byte) 0x01;
			KeyManage.SendBuff[16] = (byte) 0x01;
			KeyManage.SendBuff[17] = (byte) 0x8C;
			KeyManage.SendBuff[18] = (byte) 0x08;
			KeyManage.SendBuff[19] = (byte) 0x7F;
			KeyManage.SendBuff[20] = (byte) 0x03;
			KeyManage.SendBuff[21] = (byte) 0x03;
			KeyManage.SendBuff[22] = (byte) 0x03;
			KeyManage.SendBuff[23] = (byte) 0x03;
			KeyManage.SendBuff[24] = (byte) 0x03;
			KeyManage.SendBuff[25] = (byte) 0x03;
			KeyManage.SendBuff[26] = (byte) 0x03;
			KeyManage.SendBuff[27] = (byte) 0x8D;
			KeyManage.SendBuff[28] = (byte) 0x02;
			KeyManage.SendBuff[29] = (byte) 0x41;
			KeyManage.SendBuff[30] = (byte) 0x03;
			KeyManage.SendBuff[31] = (byte) 0x80;
			KeyManage.SendBuff[32] = (byte) 0x02;
			KeyManage.SendBuff[33] = (byte) 0x03;
			KeyManage.SendBuff[34] = (byte) 0x20;
			KeyManage.SendBuff[35] = (byte) 0xAB;
			KeyManage.SendBuff[36] = (byte) 0x0B;
			KeyManage.SendBuff[37] = (byte) 0x84;
			KeyManage.SendBuff[38] = (byte) 0x01;
			KeyManage.SendBuff[39] = (byte) 0x88;
			KeyManage.SendBuff[40] = (byte) 0xA4;
			KeyManage.SendBuff[41] = (byte) 0x06;
			KeyManage.SendBuff[42] = (byte) 0x83;
			KeyManage.SendBuff[43] = (byte) 0x01;
			KeyManage.SendBuff[44] = (byte) 0x81;
			KeyManage.SendBuff[45] = (byte) 0x95;
			KeyManage.SendBuff[46] = (byte) 0x01;
			KeyManage.SendBuff[47] = (byte) 0xFF;
			
			KeyManage.SendLen = 48;
			KeyManage.RecvLen[0] = 255;

			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Creating DF failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.clearBuffers();
			//Create Key File EF2
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE0;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x1D;
			KeyManage.SendBuff[5] = (byte) 0x62;
			KeyManage.SendBuff[6] = (byte) 0x1B;
			KeyManage.SendBuff[7] = (byte) 0x82;
			KeyManage.SendBuff[8] = (byte) 0x05;
			KeyManage.SendBuff[9] = (byte) 0x0C;
			KeyManage.SendBuff[10] = (byte) 0x41;
			KeyManage.SendBuff[11] = (byte) 0x00;
			KeyManage.SendBuff[12] = (byte) 0x16;
			KeyManage.SendBuff[13] = (byte) 0x08;
			KeyManage.SendBuff[14] = (byte) 0x83;
			KeyManage.SendBuff[15] = (byte) 0x02;
			KeyManage.SendBuff[16] = (byte) 0x11;
			KeyManage.SendBuff[17] = (byte) 0x01;
			KeyManage.SendBuff[18] = (byte) 0x88;
			KeyManage.SendBuff[19] = (byte) 0x01;
			KeyManage.SendBuff[20] = (byte) 0x02;
			KeyManage.SendBuff[21] = (byte) 0x8A;
			KeyManage.SendBuff[22] = (byte) 0x01;
			KeyManage.SendBuff[23] = (byte) 0x01;
			KeyManage.SendBuff[24] = (byte) 0x8C;
			KeyManage.SendBuff[25] = (byte) 0x08;
			KeyManage.SendBuff[26] = (byte) 0x7F;
			KeyManage.SendBuff[27] = (byte) 0x03;
			KeyManage.SendBuff[28] = (byte) 0x03;
			KeyManage.SendBuff[29] = (byte) 0x03;
			KeyManage.SendBuff[30] = (byte) 0x03;
			KeyManage.SendBuff[31] = (byte) 0x03;
			KeyManage.SendBuff[32] = (byte) 0x03;
			KeyManage.SendBuff[33] = (byte) 0x03;
			
			KeyManage.SendLen = 34;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Creating EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//Acquires the Global SAM PIN and assigns to Global array
			for(int i = 0; i < tbGlobal.getText().length() / 2; i++)
			{			
				KeyManage.Buffer[i]=(byte)((Integer)Integer.parseInt(tbGlobal.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			//Append Record To EF2, Define 8 Key Records in EF2 - Master Keys
		    //1st Master key, key ID=81, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x81; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbIssuer.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbIssuer.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Issuer Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//2nd Master key, key ID=82, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x82; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbCard.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbCard.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Card Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//3rd Master key, key ID=83, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x83; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbTerm.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbTerm.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Terminal Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//4th Master key, key ID=84, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x84; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbDebit.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbDebit.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Debit Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//5th Master key, key ID=85, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x85; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbCredit.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbCredit.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Credit Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//'6th Master key, key ID=86, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x86; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbCert.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbCert.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Certify Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			//'7th Master key, key ID=87, key type=03, int/ext authenticate, usage counter = FF FF
			KeyManage.clearBuffers();
			KeyManage.SendBuff[0] = (byte) 0x00;
			KeyManage.SendBuff[1] = (byte) 0xE2;
			KeyManage.SendBuff[2] = (byte) 0x00;
			KeyManage.SendBuff[3] = (byte) 0x00;
			KeyManage.SendBuff[4] = (byte) 0x16;
			KeyManage.SendBuff[5] = (byte) 0x87; // Key ID
			KeyManage.SendBuff[6] = (byte) 0x03;
			KeyManage.SendBuff[7] = (byte) 0xFF;
			KeyManage.SendBuff[8] = (byte) 0xFF;
			KeyManage.SendBuff[9] = (byte) 0x88;
			KeyManage.SendBuff[10] = (byte) 0x00;
			
			
			for(int i = 0; i < tbRevoke.getText().length() / 2; i++)
			{			
				KeyManage.SendBuff[i + 11]=(byte)((Integer)Integer.parseInt(tbRevoke.getText().substring(((i*2)),((i*2)+2)), 16)).byteValue();
			}
			
			KeyManage.SendLen = 19;
			KeyManage.RecvLen[0] = 255;
			
			retCode = KeyManage.sendAPDUandDisplay(1);
			
			if(retCode != 0 || (KeyManage.RecvBuff[0] != (byte) 0x90 && KeyManage.RecvBuff[1] != (byte) 0x00))
			{
				KeyManage.displayOut( 1, 0, "Appending Revoke Debit Key to EF2 failed");
				this.dispose();
				KeyManage.SAM = null;
				return;
			}
			
			KeyManage.displayOut( 0, 0, "Initializing SAM Success");		
			this.dispose();
			KeyManage.SAM = null;
			
	
		}
		
		
		if(bCancel == e.getSource())
		{
			this.dispose();
			KeyManage.SAM = null;
		}
		
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
  		if(tbGlobal.isFocusOwner() || 
  		   tbIssuer.isFocusOwner() || 
  		   tbCard.isFocusOwner()   || 
  		   tbTerm.isFocusOwner()   ||
  		   tbDebit.isFocusOwner()  || 
  		   tbCredit.isFocusOwner() ||
  		   tbCert.isFocusOwner()   ||
  		   tbRevoke.isFocusOwner())
  		{	
  		
  			if (VALIDCHARS.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);
  			
  		}
  		
  					  
		//Limit character length
  		if(tbGlobal.isFocusOwner() || 
  		   tbIssuer.isFocusOwner() || 
  	  	   tbCard.isFocusOwner()   || 
  	  	   tbTerm.isFocusOwner()   ||
  	  	   tbDebit.isFocusOwner()  || 
  	  	   tbCredit.isFocusOwner() ||
  	  	   tbCert.isFocusOwner()   ||
  	  	   tbRevoke.isFocusOwner())
  		{
  			
  			if(((JTextField)ke.getSource()).getText().length() > 16 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
	}


}
