/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              DeviceProgramming.java

  Description:       This sample program outlines the steps on how to
                     use device functions in ACR122S

  Author:            Alain Benedict Chua

  Date:              Oct 20, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/

import ACR122.*;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class DeviceProgramming extends JFrame implements ActionListener, KeyListener{
	
	static ACR122Loader acr122 = new ACR122Loader();
	static String VALIDCHARS = "0123456789";
	
	//JPCSC Variables
	int retCode;
	boolean connActive; 
	static int [] hReader = new int[1]; 
	Dialog dialog;
	
    // Variables declaration - do not modify
    private Button bClear, bConn, bQuit, bReset;
    private Button bSetBaud, bSetLedBuzz, bSetTimeout;
    private JCheckBox cT1, cT2;
    private JCheckBox cbBlink1;
    private JCheckBox cbBlink2;
    private JCheckBox cbUpdate1;
    private JCheckBox cbUpdate2;
    private JComboBox cbPort;
    private JComboBox cbBaudRate;
    private JLabel jLabel1, jLabel2, jLabel3, jLabel4, jLabel5;
    private JLabel jLabel10, jLabel6, jLabel7, jLabel8, jLabel9;
    private JPanel jPanel1, jPanel2, jPanel3, jPanel4;
    private JScrollPane jScrollPane1;
    static JTextArea mMsg;
    private JPanel mainPanel;
    private JRadioButton rbOff1;
    private JRadioButton rbOff2;
    private JRadioButton rbOff3;
    private JRadioButton rbOff4;
    private JRadioButton rbOn1;
    private JRadioButton rbOn2;
    private JRadioButton rbOn3;
    private JRadioButton rbOn4;
    private JTextField tbT1, tbT2, tbTimes;

    
    public DeviceProgramming() {
    	
    	this.setTitle("Device Programming");
        initComponents();
        initMenu();
    }
        
    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	setSize(800,703);
    	
    	//sets the location of the form at the center of screen
   		Dimension dim = getToolkit().getScreenSize();
   		Rectangle abounds = getBounds();
   		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
   		requestFocus();
   		
    	mainPanel = new JPanel();
        jLabel1 = new JLabel();
        cbPort = new JComboBox();
        jLabel2 = new JLabel();
        cbBaudRate = new JComboBox();
        bConn = new java.awt.Button();
        bSetBaud = new java.awt.Button();
        bSetTimeout = new java.awt.Button();
        jPanel1 = new JPanel();
        jPanel2 = new JPanel();
        jLabel3 = new JLabel();
        jLabel4 = new JLabel();
        jLabel5 = new JLabel();
        tbT1 = new JTextField();
        tbT2 = new JTextField();
        tbTimes = new JTextField();
        jLabel6 = new JLabel();
        cT1 = new JCheckBox();
        cT2 = new JCheckBox();
        jPanel3 = new JPanel();
        jLabel7 = new JLabel();
        jLabel8 = new JLabel();
        rbOn1 = new JRadioButton();
        rbOff1 = new JRadioButton();
        rbOn2 = new JRadioButton();
        rbOff2 = new JRadioButton();
        cbUpdate1 = new JCheckBox();
        cbBlink1 = new JCheckBox();
        jPanel4 = new JPanel();
        jLabel9 = new JLabel();
        jLabel10 = new JLabel();
        rbOn3 = new JRadioButton();
        rbOff3 = new JRadioButton();
        rbOn4 = new JRadioButton();
        rbOff4 = new JRadioButton();
        cbUpdate2 = new JCheckBox();
        cbBlink2 = new JCheckBox();
        bSetLedBuzz = new java.awt.Button();
        jScrollPane1 = new JScrollPane();
        mMsg = new JTextArea();
        bReset = new java.awt.Button();
        bClear = new java.awt.Button();
        bQuit = new java.awt.Button();

        mainPanel.setName("mainPanel"); 

        
        jLabel1.setText("Select Port:"); 
        jLabel1.setName("jLabel1"); 

        cbPort.setModel(new DefaultComboBoxModel(new String[] { "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10"}));
        cbPort.setName("jComboBox1"); 

        jLabel2.setText("Baud Rate:"); 
        jLabel2.setName("jLabel2"); 

        cbBaudRate.setModel(new DefaultComboBoxModel(new String[] { "9600", "115200" }));
        cbBaudRate.setName("cbBaudRate"); 

        bConn.setLabel("Connect"); 
        bConn.setName("bConn"); 

        bSetBaud.setLabel("Set Baud Rate"); 
        bSetBaud.setName("bSetBaud"); 

        bSetTimeout.setLabel("Set Timeouts"); 
        bSetTimeout.setName("bSetTimeout"); 

        jPanel1.setBorder(BorderFactory.createTitledBorder(null, "Set LED States with Beep")); 
        jPanel1.setName("jPanel1"); 

        jPanel2.setBorder(BorderFactory.createTitledBorder(null, "Buzzer")); 
        jPanel2.setName("jPanel2"); 

        jLabel3.setText("T1 (ms):"); 
        jLabel3.setName("jLabel3"); 

        jLabel4.setText("T2 (ms):"); 
        jLabel4.setName("jLabel4"); 

        jLabel5.setText("Times:"); 
        jLabel5.setName("jLabel5"); 

        tbT1.setText(""); 
        tbT1.setName("tbT1"); 

        tbT2.setText(""); 
        tbT2.setName("tbT2"); 

        tbTimes.setText(""); 
        tbTimes.setName("tbTimes"); 

        jLabel6.setText("Buzzer Mode:"); 
        jLabel6.setName("jLabel6"); 

        cT1.setText("On-T1"); 
        cT1.setName("cT1"); 

        cT2.setText("On-T2"); 
        cT2.setName("cT2"); 

        GroupLayout jPanel2Layout = new GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tbT1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, 70)
                        .addGap(45, 45, 45)
                        .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel6)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(10, 10, 10)
                                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(cT2)
                                    .addComponent(cT1)))))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel5)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tbTimes, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, 70))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel4)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tbT2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, 70)))
                .addContainerGap(54, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(tbT1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addGap(13, 13, 13)
                        .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(tbT2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel5)
                            .addComponent(tbTimes, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel6)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cT1)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cT2)))
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel3.setBorder(BorderFactory.createTitledBorder(null, "LED 0")); 
        jPanel3.setName("jPanel3"); 

        jLabel7.setText("Final State:"); 
        jLabel7.setName("jLabel7"); 

        jLabel8.setText("Initial Blinking State:"); 
        jLabel8.setName("jLabel8"); 

        rbOn1.setText("On"); 
        rbOn1.setName("rbOn1"); 

        rbOff1.setText("Off"); 
        rbOff1.setName("rbOff1"); 

        rbOn2.setText("On"); 
        rbOn2.setName("rbOn2"); 

        rbOff2.setText("Off"); 
        rbOff2.setName("rbOff2"); 

        cbUpdate1.setText("Enable Update"); 
        cbUpdate1.setName("cbUpdate1"); 

        cbBlink1.setText("Enable Blink"); 
        cbBlink1.setName("cbBlink1"); 

        GroupLayout jPanel3Layout = new GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(37, 37, 37)
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addComponent(cbUpdate1)
                        .addGap(18, 18, 18)
                        .addComponent(cbBlink1))
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel7)
                            .addComponent(jLabel8))
                        .addGap(59, 59, 59)
                        .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel3Layout.createSequentialGroup()
                                .addComponent(rbOn1)
                                .addGap(18, 18, 18)
                                .addComponent(rbOff1))
                            .addGroup(jPanel3Layout.createSequentialGroup()
                                .addComponent(rbOn2)
                                .addGap(18, 18, 18)
                                .addComponent(rbOff2)))))
                .addContainerGap(69, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(rbOn1)
                    .addComponent(rbOff1))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel8)
                    .addComponent(rbOn2)
                    .addComponent(rbOff2))
                .addGap(18, 18, 18)
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(cbUpdate1)
                    .addComponent(cbBlink1))
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel4.setBorder(BorderFactory.createTitledBorder(null, "LED 1")); 
        jPanel4.setName("jPanel4"); 

        jLabel9.setText("Final State:"); 
        jLabel9.setName("jLabel9"); 

        jLabel10.setText("Initial Blinking State:"); 
        jLabel10.setName("jLabel10"); 

        rbOn3.setText("On"); 
        rbOn3.setName("rbOn3"); 

        rbOff3.setText("Off"); 
        rbOff3.setName("rbOff3"); 

        rbOn4.setText("On"); 
        rbOn4.setName("rbOn4"); 

        rbOff4.setText("Off"); 
        rbOff4.setName("rbOff4"); 

        cbUpdate2.setText("Enable Update"); 
        cbUpdate2.setName("cbUpdate2"); 

        cbBlink2.setText("Enable Blink"); 
        cbBlink2.setName("cbBlink2"); 

        GroupLayout jPanel4Layout = new GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(37, 37, 37)
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(cbUpdate2)
                        .addGap(18, 18, 18)
                        .addComponent(cbBlink2))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel9)
                            .addComponent(jLabel10))
                        .addGap(59, 59, 59)
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(rbOn3)
                                .addGap(18, 18, 18)
                                .addComponent(rbOff3))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(rbOn4)
                                .addGap(18, 18, 18)
                                .addComponent(rbOff4)))))
                .addContainerGap(69, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel9)
                    .addComponent(rbOn3)
                    .addComponent(rbOff3))
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(rbOn4)
                    .addComponent(rbOff4))
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(cbUpdate2)
                    .addComponent(cbBlink2))
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        bSetLedBuzz.setLabel("Set LED and Buzzer"); 
        bSetLedBuzz.setName("bSetLedBuzz"); 

        GroupLayout jPanel1Layout = new GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addComponent(jPanel3, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel2, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel4, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(65, 65, 65)
                .addComponent(bSetLedBuzz, GroupLayout.PREFERRED_SIZE, 160, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(88, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jPanel2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel3, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel4, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bSetLedBuzz, GroupLayout.DEFAULT_SIZE, 24, Short.MAX_VALUE)
                .addContainerGap())
        );

        jScrollPane1.setName("jScrollPane1"); 

        mMsg.setColumns(20);
        mMsg.setRows(5);
        mMsg.setName("jTextArea1"); 
        jScrollPane1.setViewportView(mMsg);

        bReset.setLabel("Reset"); 
        bReset.setName("bReset"); 

        bClear.setLabel("Clear"); 
        bClear.setName("bClear"); 

        bQuit.setLabel("Quit"); 
        bQuit.setName("bQuit"); 

        GroupLayout mainPanelLayout = new GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel1)
                            .addComponent(jLabel2))
                        .addGap(27, 27, 27)
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING, false)
                            .addComponent(cbBaudRate, 0, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(cbPort, 0, 101, Short.MAX_VALUE))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(bConn, GroupLayout.DEFAULT_SIZE, 144, Short.MAX_VALUE)
                            .addComponent(bSetBaud, GroupLayout.DEFAULT_SIZE, 144, Short.MAX_VALUE)
                            .addComponent(bSetTimeout, GroupLayout.Alignment.TRAILING, GroupLayout.DEFAULT_SIZE, 144, Short.MAX_VALUE)))
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING, false)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addComponent(jScrollPane1, GroupLayout.PREFERRED_SIZE, 353, GroupLayout.PREFERRED_SIZE)
                        .addContainerGap())
                    .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                        .addComponent(bClear, GroupLayout.PREFERRED_SIZE, 110, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(bReset, GroupLayout.PREFERRED_SIZE, 110, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(bQuit, GroupLayout.PREFERRED_SIZE, 110, GroupLayout.PREFERRED_SIZE)
                        .addGap(11, 11, 11))))
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addComponent(jScrollPane1, GroupLayout.PREFERRED_SIZE, 537, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                            .addComponent(bReset, GroupLayout.DEFAULT_SIZE, 43, Short.MAX_VALUE)
                            .addComponent(bClear, GroupLayout.DEFAULT_SIZE, 43, Short.MAX_VALUE)
                            .addComponent(bQuit, GroupLayout.DEFAULT_SIZE, 43, Short.MAX_VALUE)))
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addGroup(mainPanelLayout.createSequentialGroup()
                                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel1)
                                    .addComponent(cbPort, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel2)
                                    .addComponent(cbBaudRate, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                            .addGroup(mainPanelLayout.createSequentialGroup()
                                .addComponent(bConn, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(bSetBaud, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(bSetTimeout, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addGap(8, 8, 8)
                        .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                .addGap(102, 102, 102))
        );   
       
        bConn.addActionListener(this);
        bClear.addActionListener(this);
        bQuit.addActionListener(this);
        bReset.addActionListener(this);
        bSetBaud.addActionListener(this);
        bSetLedBuzz.addActionListener(this);
        bSetTimeout.addActionListener(this);
        
        rbOn1.addActionListener(this);
        rbOn2.addActionListener(this);
        rbOn3.addActionListener(this);
        rbOn4.addActionListener(this);
        
        rbOff1.addActionListener(this);
        rbOff2.addActionListener(this);
        rbOff3.addActionListener(this);
        rbOff4.addActionListener(this);
        
        tbT1.addKeyListener(this);
        tbT2.addKeyListener(this);
        tbTimes.addKeyListener(this);
 

    }
    

	public void actionPerformed(ActionEvent e) {
    	
    	int  [] FWLEN = new int[1];
    	int tempInt;
    	char tempChar;
    	byte [] tempstr = new byte[255];
    	String tmpStr = "";
    	
    	if(bSetTimeout == e.getSource())
    	{
    		dialog = null;
    		dialog = new Dialog();	
    		dialog.setVisible(true);	

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
				enableAll(true);
				
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
    	
    	if(bSetBaud == e.getSource())
    	{
    		
    		retCode = acr122.jACR122_SetBaudRate(hReader, Integer.parseInt((String)cbBaudRate.getSelectedItem()));
    		
    		if(retCode == 0)
    		{
    			displayOut( 0, 0, "Set baud rate success");
    		}
    		else
    		{
    			displayOut( 1, 0, "Set baud rate failed");
    		}
    		
    	}
    	
    	if(bSetLedBuzz == e.getSource())
    	{
    		ACR122_LED_CONTROL [] ledCtrl = new ACR122_LED_CONTROL[2];
    		ledCtrl[0] = new ACR122_LED_CONTROL();
    		ledCtrl[1] = new ACR122_LED_CONTROL();
    		
    		int t1 = 0 , t2 = 0, num = 0;
    		int buzzmode = 0;
    		
    		if(tbT1.getText().length() == 0)
    		{
    			tbT1.requestFocus();
    			return;
    		}
    		
    		if(tbT2.getText().length() == 0)
    		{
    			tbT2.requestFocus();
    			return;
    		}
    		
    		if(tbTimes.getText().length() == 0)
    		{
    			tbTimes.requestFocus();
    			return;
    		}
    		
    		if(Integer.parseInt(tbT1.getText()) > 25500)
    		{
    			tbT1.setText("25500");
    			tbT1.requestFocus();
    			return;
    		}
    		
    		if(Integer.parseInt(tbT2.getText()) > 25500)
    		{
    			tbT2.setText("25500");
    			tbT2.requestFocus();
    			return;
    		}
    		
    		if(Integer.parseInt(tbTimes.getText()) > 255)
    		{
    			tbTimes.setText("255");
    			tbTimes.requestFocus();
    			return;
    		}
    		
  		  		
    		// L0 Final State
    		if(rbOn1.isSelected())
    		{
    			ledCtrl[0].finalState = ACR122Loader.ACR122_LED_STATE_ON;
    		}
    		else
    		{
    			ledCtrl[0].finalState = ACR122Loader.ACR122_LED_STATE_OFF;
    		}
    		
    		// LO Initial Blinking State
    		if(rbOn2.isSelected())
    		{
    			ledCtrl[0].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_ON;
    		}
    		else
    		{
    			ledCtrl[0].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_OFF;
    		}
    		
    		// L1 Final State
    		if(rbOn3.isSelected())
    		{
    			ledCtrl[1].finalState = ACR122Loader.ACR122_LED_STATE_ON;
    		}
    		else
    		{
    			ledCtrl[1].finalState = ACR122Loader.ACR122_LED_STATE_OFF;
    		}
    		
    		// L1 Initial Blinking State
    		if(rbOn4.isSelected())
    		{
    			ledCtrl[1].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_ON;
    		}
    		else
    		{
    			ledCtrl[1].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_OFF;
    		}
    		
    		//L0 Enable Blink
    		if(cbBlink1.isSelected())
    		{
    			ledCtrl[0].blinkEnabled = true;
    		}
    		else
    		{
    			ledCtrl[0].blinkEnabled = false;
    		}
    		
    		//L1 Enable Blink
    		if(cbBlink2.isSelected())
    		{
    			ledCtrl[1].blinkEnabled = true;
    		}
    		else
    		{
    			ledCtrl[1].blinkEnabled = false;
    		}
    		
    		//L0 Enable Update
    		if(cbUpdate1.isSelected())
    		{
    			ledCtrl[0].updateEnabled = true;
    		}
    		else
    		{
    			ledCtrl[0].updateEnabled = false;
    		}
    		
    		//L1 Enable Update
    		if(cbUpdate2.isSelected())
    		{
    			ledCtrl[1].updateEnabled = true;
    		}
    		else
    		{
    			ledCtrl[1].updateEnabled = false;
    		}
    		
    		if(cT1.isSelected())
    		{
    			buzzmode = ACR122Loader.ACR122_BUZZER_MODE_ON_T1;
    		}
    		
    		if(cT2.isSelected())
    		{
    			buzzmode = ACR122Loader.ACR122_BUZZER_MODE_ON_T2;
    		}
    		
    		if(cT1.isSelected() && cT2.isSelected())
    		{
    			buzzmode = ACR122Loader.ACR122_BUZZER_MODE_ON_T1 | ACR122Loader.ACR122_BUZZER_MODE_ON_T2;
    		}
    		
    		if(cT1.isSelected() == false && cT2.isSelected() == false)
    		{
    			buzzmode = ACR122Loader.ACR122_BUZZER_MODE_OFF;
    		}
    		
    		t1 = Integer.parseInt(tbT1.getText());
    		t2 = Integer.parseInt(tbT2.getText());
    		num = Integer.parseInt(tbTimes.getText());
    		
    		retCode = acr122.jACR122_SetLedStatesWithBeep(hReader, ledCtrl, 2, t1, t2, num, buzzmode);
    		
    		if(retCode == 0)
    		{
    			displayOut( 0, 0, "Set LED States with Beep success");
    		}
    		else
    		{
    			displayOut( 1, 0, "Set LED States with Beep failed");
    		}
    		
    		
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
    	
    	if(rbOn1 == e.getSource())
    	{
    		rbOn1.setSelected(true);
    		rbOff1.setSelected(false);	
    	}
    	if(rbOn2 == e.getSource())
    	{
    		rbOn2.setSelected(true);
    		rbOff2.setSelected(false);	
    	}
    	if(rbOn3 == e.getSource())
    	{
    		rbOn3.setSelected(true);
    		rbOff3.setSelected(false);	
    	}
    	if(rbOn4 == e.getSource())
    	{
    		rbOn4.setSelected(true);
    		rbOff4.setSelected(false);	
    	}
    	
    	if(rbOff1 == e.getSource())
    	{
    		rbOn1.setSelected(false);
    		rbOff1.setSelected(true);	
    	}
    	if(rbOff2 == e.getSource())
    	{
    		rbOn2.setSelected(false);
    		rbOff2.setSelected(true);	
    	}
    	if(rbOff3 == e.getSource())
    	{
    		rbOn3.setSelected(false);
    		rbOff3.setSelected(true);	
    	}
    	if(rbOff4 == e.getSource())
    	{
    		rbOn4.setSelected(false);
    		rbOff4.setSelected(true);	
    	}
    	
    	
    }
    
    public void initMenu()
	{
    	
       connActive = false;
       bConn.setEnabled(true);
       enableAll(false);
       
       rbOn1.setSelected(true);
       rbOn2.setSelected(true);
       rbOn3.setSelected(true);
       rbOn4.setSelected(true);
       
       
       displayOut(0, 0, "Program Ready");
	}
    
    public void enableAll(boolean option){
    	
    	bSetBaud.setEnabled(option);
    	bSetTimeout.setEnabled(option);
    	tbT1.setEnabled(option);
    	tbT2.setEnabled(option);
    	tbTimes.setEnabled(option);
    	rbOn1.setEnabled(option);
    	rbOn2.setEnabled(option);
    	rbOn3.setEnabled(option);
    	rbOn4.setEnabled(option);
    	rbOff1.setEnabled(option);
    	rbOff2.setEnabled(option);
    	rbOff3.setEnabled(option);
    	rbOff4.setEnabled(option);
    	cT1.setEnabled(option);
    	cT2.setEnabled(option);
    	cbBlink1.setEnabled(option);
    	cbBlink2.setEnabled(option);
    	cbUpdate1.setEnabled(option);
    	cbUpdate2.setEnabled(option);
    	bReset.setEnabled(option);
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
  		if(tbT1.isFocusOwner() || tbT2.isFocusOwner() || tbTimes.isFocusOwner())
  		{	
  		
  			if (VALIDCHARS.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);
  			
  		}
  		
  					  
		//Limit character length
  		if(tbT1.isFocusOwner() || tbT2.isFocusOwner() || tbTimes.isFocusOwner())
  		{
  			
  			if(((JTextField)ke.getSource()).getText().length() >= 10 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
	    	
	}
    
    public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new DeviceProgramming().setVisible(true);
            }
        });
    }

}
