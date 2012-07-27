/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              mainMifareProg.java

  Description:       This sample program outlines the steps on how to
                     use Mifare functions in ACR122S

  Author:            Alain Benedict Chua

  Date:              Oct 20, 2009

  Revision Trail:   (Date/Author/Description)

======================================================================*/


import ACR122.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class mainMifareProg extends JFrame implements ActionListener, KeyListener{

	static ACR122Loader acr122 = new ACR122Loader();
	//JPCSC Variables
	int retCode;
	boolean connActive, validATS; 
	static String VALIDCHARS = "0123456789";
	static String VALIDCHARSHEX = "ABCDEFabcdef0123456789";
	Timer timer;
	
	//All variables that requires pass-by-reference calls to functions are
	//declared as 'Array of int' with length 1
	//Java does not process pass-by-ref to int-type variables, thus Array of int was used.
	int [] ATRLen = new int[1]; 
	int [] hReader = new int[1]; 
	int [] cchReaders = new int[1];
	int [] hCard = new int[1];
	int [] PrefProtocols = new int[1]; 		
	int [] RecvLen = new int[1];
	int SendLen = 0;
	int [] nBytesRet =new int[1];
	byte [] SendBuff = new byte[255];
	byte [] RecvBuff = new byte[255];
	int reqType;

	
	// Variables declaration - do not modify
    private JTextArea mMsg;
    private java.awt.Button bAuth, bClear, bConn, bQuit, bRead;
    private java.awt.Button bReset, bUpdate, bValCopy, bValDec, bValInc, bValRead, bValStore;
    private JComboBox cbPort;
    private JLabel jLabel1, jLabel2, jLabel3 ,jLabel4;
    private JLabel jLabel5, jLabel6, jLabel7, jLabel8, jLabel9;
    private JPanel jPanel1;
    private JPanel jPanel2;
    private JPanel jPanel3;
    private JPanel jPanel4;
    private JScrollPane jScrollPane1;
    private JPanel mainPanel;
    private JRadioButton rTypea;
    private JRadioButton rTypeb;
    private JTextField tBinBlock;
    private JTextField tBlkNo;
    private JTextField tData;
    private JTextField tKey1;
    private JTextField tKey2;
    private JTextField tKey3;
    private JTextField tKey4;
    private JTextField tKey5;
    private JTextField tKey6;
    private JTextField tValAmount;
    private JTextField tValBlock;
    private JTextField tValSrc;
    private JTextField tValTarget;
	

    public mainMifareProg() {
    	
    	this.setTitle("Mifare Card Programming");
        initComponents();
        initMenu();
    }

    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);

    	setSize(750,530);
    	
    	//sets the location of the form at the center of screen
   		Dimension dim = getToolkit().getScreenSize();
   		Rectangle abounds = getBounds();
   		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
   		requestFocus();
   		
    	mainPanel = new JPanel();
        jPanel1 = new JPanel();
        jPanel2 = new JPanel();
        rTypea = new JRadioButton();
        rTypeb = new JRadioButton();
        jLabel1 = new JLabel();
        tBlkNo = new JTextField();
        jLabel2 = new JLabel();
        tKey1 = new JTextField();
        tKey2 = new JTextField();
        tKey3 = new JTextField();
        tKey4 = new JTextField();
        tKey5 = new JTextField();
        tKey6 = new JTextField();
        bAuth = new java.awt.Button();
        jLabel3 = new JLabel();
        cbPort = new JComboBox();
        jPanel3 = new JPanel();
        jLabel4 = new JLabel();
        jLabel5 = new JLabel();
        tData = new JTextField();
        tBinBlock = new JTextField();
        bRead = new java.awt.Button();
        bUpdate = new java.awt.Button();
        jScrollPane1 = new JScrollPane();
        mMsg = new JTextArea();
        jPanel4 = new JPanel();
        jLabel6 = new JLabel();
        jLabel7 = new JLabel();
        jLabel8 = new JLabel();
        jLabel9 = new JLabel();
        tValAmount = new JTextField();
        tValBlock = new JTextField();
        tValSrc = new JTextField();
        tValTarget = new JTextField();
        bValStore = new java.awt.Button();
        bValRead = new java.awt.Button();
        bValInc = new java.awt.Button();
        bValDec = new java.awt.Button();
        bValCopy = new java.awt.Button();
        bConn = new java.awt.Button();
        bClear = new java.awt.Button();
        bReset = new java.awt.Button();
        bQuit = new java.awt.Button();

        mainPanel.setBorder(BorderFactory.createTitledBorder(""));
        mainPanel.setName("mainPanel"); 

        jPanel1.setBorder(BorderFactory.createTitledBorder("Authentication")); 
        jPanel1.setName("jPanel1"); 

        jPanel2.setBorder(BorderFactory.createTitledBorder("Key Type")); 
        jPanel2.setName("jPanel2"); 

        rTypea.setText("Type A"); 
        rTypea.setName("rTypea"); 

        rTypeb.setText("Type B"); 
        rTypeb.setName("rTypeb"); 

        GroupLayout jPanel2Layout = new GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(24, 24, 24)
                .addComponent(rTypea)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 43, Short.MAX_VALUE)
                .addComponent(rTypeb)
                .addGap(30, 30, 30))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(rTypeb)
                    .addComponent(rTypea))
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jLabel1.setText("Block No"); 
        jLabel1.setName("jLabel1"); 

        tBlkNo.setText(""); 
        tBlkNo.setName("tBlkNo"); 

        jLabel2.setText("Key Value"); 
        jLabel2.setName("jLabel2"); 

        tKey1.setName("tKey1"); 

        tKey2.setName("tKey2"); 

        tKey3.setName("tKey3"); 

        tKey4.setName("tKey4"); 

        tKey5.setName("tKey5"); 

        tKey6.setName("tKey6"); 

        bAuth.setLabel("Authenticate"); 
        bAuth.setName("bAuth"); 

        GroupLayout jPanel1Layout = new GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.TRAILING, false)
                    .addComponent(bAuth, GroupLayout.Alignment.LEADING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(tBlkNo, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE))
                    .addGroup(GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey1, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey2, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey3, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey4, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey5, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tKey6, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel2, GroupLayout.Alignment.LEADING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(28, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jPanel2, GroupLayout.PREFERRED_SIZE, 52, GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(tBlkNo, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel2)
                    .addGroup(jPanel1Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                        .addComponent(tKey1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addComponent(tKey2, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addComponent(tKey3, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addComponent(tKey4, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addComponent(tKey5, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addComponent(tKey6, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bAuth, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addGap(7, 7, 7))
        );

        jLabel3.setText("Select Port:"); 
        jLabel3.setName("jLabel3"); 

        cbPort.setModel(new DefaultComboBoxModel(new String[] { "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10" }));
        cbPort.setName("cbPort"); 

        jPanel3.setBorder(BorderFactory.createTitledBorder("Binary Block Functions")); 
        jPanel3.setName("jPanel3"); 

        jLabel4.setText("Block No"); 
        jLabel4.setName("jLabel4"); 

        jLabel5.setText("Data"); 
        jLabel5.setName("jLabel5"); 

        tData.setText(""); 
        tData.setName("tData"); 

        tBinBlock.setName("tBinBlock"); 

        bRead.setLabel("Read Block"); 
        bRead.setName("bRead"); 

        bUpdate.setLabel("Update Block"); 
        bUpdate.setName("bUpdate"); 

        GroupLayout jPanel3Layout = new GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGap(2, 2, 2)
                        .addComponent(jLabel4)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(tBinBlock, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel5))
                .addContainerGap(198, Short.MAX_VALUE))
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(36, 36, 36)
                .addComponent(bRead, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 36, Short.MAX_VALUE)
                .addComponent(bUpdate, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addGap(83, 83, 83))
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addComponent(tData, GroupLayout.DEFAULT_SIZE, 259, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(tBinBlock, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jLabel5)
                .addPreferredGap(LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(tData, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel3Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(bRead, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                    .addComponent(bUpdate, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addGap(25, 25, 25))
        );

        jScrollPane1.setName("jScrollPane1"); 

        mMsg.setColumns(20);
        mMsg.setRows(5);
        mMsg.setName("mMsg"); 
        jScrollPane1.setViewportView(mMsg);

        jPanel4.setBorder(BorderFactory.createTitledBorder("Static")); 
        jPanel4.setName("jPanel4"); 

        jLabel6.setText("Value Amount"); 
        jLabel6.setName("jLabel6"); 

        jLabel7.setText("Block No"); 
        jLabel7.setName("jLabel7"); 

        jLabel8.setText("Source Block"); 
        jLabel8.setName("jLabel8"); 

        jLabel9.setText("Target Block"); 
        jLabel9.setName("jLabel9"); 

        tValAmount.setText(""); 
        tValAmount.setName("tValAmount"); 

        tValBlock.setName("tValBlock"); 

        tValSrc.setName("tValSrc"); 

        tValTarget.setName("tValTarget"); 

        bValStore.setLabel("Store Value"); 
        bValStore.setName("bValStore"); 

        bValRead.setLabel("Read Value"); 
        bValRead.setName("bValRead"); 

        bValInc.setLabel("Increment"); 
        bValInc.setName("bValInc"); 

        bValDec.setLabel("Decrement"); 
        bValDec.setName("bValDec"); 

        bValCopy.setLabel("Copy Block"); 
        bValCopy.setName("bValCopy"); 

        GroupLayout jPanel4Layout = new GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel6)
                            .addComponent(jLabel7)
                            .addComponent(jLabel8)
                            .addComponent(jLabel9))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addGroup(GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(tValSrc, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tValBlock, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(tValTarget, GroupLayout.PREFERRED_SIZE, 25, GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 169, Short.MAX_VALUE)
                                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                                    .addComponent(bValRead, GroupLayout.Alignment.TRAILING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(bValInc, GroupLayout.Alignment.TRAILING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                    .addComponent(bValDec, GroupLayout.Alignment.TRAILING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(tValAmount, GroupLayout.PREFERRED_SIZE, 91, GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 103, Short.MAX_VALUE)
                                .addComponent(bValStore, GroupLayout.PREFERRED_SIZE, 100, GroupLayout.PREFERRED_SIZE))))
                    .addComponent(bValCopy, GroupLayout.Alignment.TRAILING, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        jPanel4Layout.linkSize(SwingConstants.HORIZONTAL, new java.awt.Component[] {bValCopy, bValDec, bValInc, bValRead, bValStore});

        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                            .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                                .addComponent(jLabel6)
                                .addComponent(tValAmount, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                            .addComponent(bValStore, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addGap(21, 21, 21)
                                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel8)
                                    .addComponent(tValSrc, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel4Layout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel9)
                                    .addComponent(tValTarget, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(bValRead, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(bValInc, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(bValDec, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(40, 40, 40)
                        .addComponent(jLabel7))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(40, 40, 40)
                        .addComponent(tValBlock, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bValCopy, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                .addContainerGap(25, Short.MAX_VALUE))
        );

        bConn.setLabel("Connect"); 
        bConn.setName("bConn"); 

        bClear.setLabel("Clear"); 
        bClear.setName("bClear"); 

        bReset.setLabel("Reset"); 
        bReset.setName("bReset"); 

        bQuit.setLabel("Quit"); 
        bQuit.setName("bQuit"); 

        GroupLayout mainPanelLayout = new GroupLayout(getContentPane());
        getContentPane().setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.TRAILING)
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(bConn, GroupLayout.PREFERRED_SIZE, 113, GroupLayout.PREFERRED_SIZE))
                    .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                        .addGroup(mainPanelLayout.createSequentialGroup()
                            .addContainerGap()
                            .addComponent(jPanel3, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGroup(mainPanelLayout.createSequentialGroup()
                            .addGap(118, 118, 118)
                            .addComponent(jLabel3)
                            .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(cbPort, 0, 117, Short.MAX_VALUE))
                        .addGroup(mainPanelLayout.createSequentialGroup()
                            .addContainerGap()
                            .addComponent(jPanel1, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                        .addComponent(bClear, GroupLayout.PREFERRED_SIZE, 95, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 66, Short.MAX_VALUE)
                        .addComponent(bReset, GroupLayout.PREFERRED_SIZE, 85, GroupLayout.PREFERRED_SIZE)
                        .addGap(58, 58, 58)
                        .addComponent(bQuit, GroupLayout.PREFERRED_SIZE, 96, GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1, GroupLayout.Alignment.TRAILING, GroupLayout.DEFAULT_SIZE, 400, Short.MAX_VALUE)
                    .addComponent(jPanel4, GroupLayout.Alignment.TRAILING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(mainPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addGroup(GroupLayout.Alignment.TRAILING, mainPanelLayout.createSequentialGroup()
                        .addComponent(jPanel4, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(11, 11, 11)
                        .addComponent(jScrollPane1, GroupLayout.PREFERRED_SIZE, 229, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.LEADING)
                            .addComponent(bClear, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                            .addComponent(bQuit, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                            .addComponent(bReset, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addGap(230, 230, 230))
                    .addGroup(mainPanelLayout.createSequentialGroup()
                        .addGroup(mainPanelLayout.createParallelGroup(GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(cbPort, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
                        .addGap(6, 6, 6)
                        .addComponent(bConn, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel1, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jPanel3, GroupLayout.PREFERRED_SIZE, 183, GroupLayout.PREFERRED_SIZE)
                        .addContainerGap())))
        );
      
        bConn.addActionListener(this);
        bReset.addActionListener(this);
        bQuit.addActionListener(this);
        bClear.addActionListener(this);
        bAuth.addActionListener(this);
        bRead.addActionListener(this);
        bUpdate.addActionListener(this);
        bValStore.addActionListener(this);
        bValInc.addActionListener(this);
        bValDec.addActionListener(this);
        bValRead.addActionListener(this);
        bValCopy.addActionListener(this);
        rTypea.addActionListener(this);
        rTypeb.addActionListener(this);
        rTypea.setSelected(true);
        
        
        tKey1.addKeyListener(this);
        tKey2.addKeyListener(this);
        tKey3.addKeyListener(this);
        tKey4.addKeyListener(this);
        tKey5.addKeyListener(this);
        tKey6.addKeyListener(this);
        tBlkNo.addKeyListener(this);
        tBinBlock.addKeyListener(this);
        tValAmount.addKeyListener(this);
        tValBlock.addKeyListener(this);
        tValSrc.addKeyListener(this);
        tValTarget.addKeyListener(this);
        
          
    }

	public void actionPerformed(ActionEvent e) 
	{
		int  [] FWLEN = new int[1];
		int tempInt, pVal;
	    long  tempLong;
		char tempChar;
		byte [] tempstr = new byte[255];
		byte [] UID = new byte[4];
		String tmpStr = "";
		
		
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
		
		if(bAuth == e.getSource())
		{
			retCode = checkAuthInput();
			
			if(retCode == 0)
			{
				clearBuffers();
				SendBuff[0] = (byte) 0xD4;
				SendBuff[1] = (byte) 0x4A;
				SendBuff[2] = (byte) 0x01;
				SendBuff[3] = (byte) 0x00;
				
				SendLen = 4;
				
				retCode = sendAPDUandDisplay();
				
				if(retCode == 0)
				{
					for(int i = 8; i < RecvBuff[7] + 8; i++)
					{
						UID[i - 8] = RecvBuff[i];
					}
					
					clearBuffers();
					
					SendBuff[0] = (byte) 0xD4;
					SendBuff[1] = (byte) 0x40;
					SendBuff[2] = (byte) 0x01;
					
					if(rTypea.isSelected() == true)
					{
						SendBuff[3] = (byte) 0x60;
					}
					else
					{
						SendBuff[3] = (byte) 0x61;
					}
					
					SendBuff[4]  = (byte) ((Integer)Integer.parseInt(tBlkNo.getText(), 16)).byteValue();
					SendBuff[5]  = (byte) ((Integer)Integer.parseInt(tKey1.getText(), 16)).byteValue();
					SendBuff[6]  = (byte) ((Integer)Integer.parseInt(tKey2.getText(), 16)).byteValue();
					SendBuff[7]  = (byte) ((Integer)Integer.parseInt(tKey3.getText(), 16)).byteValue();
					SendBuff[8]  = (byte) ((Integer)Integer.parseInt(tKey4.getText(), 16)).byteValue();
					SendBuff[9]  = (byte) ((Integer)Integer.parseInt(tKey5.getText(), 16)).byteValue();
					SendBuff[10] = (byte) ((Integer)Integer.parseInt(tKey6.getText(), 16)).byteValue();
					
					SendBuff[11] = UID[0];
					SendBuff[12] = UID[1];
					SendBuff[13] = UID[2];
					SendBuff[14] = UID[3];
					
					SendLen = 15;
					RecvLen[0] = 255;
					
					retCode = sendAPDUandDisplay();
					
					if(retCode == 0)
					{
						displayOut( 0, 0, "Authentication Success");
					}
					else
					{
						displayOut( 1, 0, "Authentication Failed");
					}					
				}
				else
				{
					displayOut( 1, 0, "Authentication Failed");
				}
						
			}
			
		}
		
		if(bRead == e.getSource())
		{
			clearBuffers();
			
		    SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0x30;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tBinBlock.getText(), 16)).byteValue();
		    
		    SendLen = 5;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		    
		    if(retCode == 0 && RecvLen[0] > 4)
		    {
		    	displayOut( 0, 0, "Read Block Success");
		    	
		    	for(int i = 3; i < RecvLen[0]; i++)
		    	{    						
					tempInt = Integer.parseInt(Integer.toHexString(((Byte)RecvBuff[i]).intValue() & 0xFF).toUpperCase(), 16);
					
					tempChar = (char) tempInt;
					
					tmpStr += tempChar;			
		    	}
		    	
		    	tData.setText(tmpStr);
		    }
		    else
		    {
		    	displayOut( 1, 0, "Read Block Failed");
		    }
			
		}
		
		if(bUpdate == e.getSource())
		{
			clearBuffers();
			
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0xA0;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tBinBlock.getText(), 16)).byteValue();
		      	    
		    for(int i = 0; i < tData.getText().length(); i++)
		    {
		    	SendBuff[i + 5] = (byte)(int) (tData.getText().charAt(i));
		    }
		    
		    SendLen = 21;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		    
		    if(retCode == 0)
		    {
		    	displayOut( 0, 0, "Update Block Success");
		    }
		    else
		    {
		    	displayOut( 1, 0, "Update Block Failed");
		    }
		    		
		}
		
		if(bValStore == e.getSource())
		{
			
			if(tValAmount.getText().length() == 0)
			{
				tValAmount.requestFocus();
				return;
			}
			
			if(tValBlock.getText().length() == 0)
			{
				tValBlock.requestFocus();
				return;
			}
			
			clearBuffers();
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0xA0;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
		    
		    tempInt = Integer.parseInt(tValAmount.getText());
		    
		    pVal = Integer.parseInt(tValAmount.getText());
		    
		    if(pVal >= 0)
		    {
		        //Computation of pVal
			  	tempInt = pVal % 256;
			  	SendBuff[5] =  (byte)tempInt;

				tempInt = pVal / 256;
				tempInt = tempInt % 256;
			  	SendBuff[6] = (byte)tempInt;

			  	tempInt = pVal / 256;
			  	tempInt = tempInt / 256;
			  	tempInt = tempInt % 256;
			  	SendBuff[7] = (byte)tempInt;

			    tempInt = pVal / 256;
			  	tempInt = tempInt / 256;
				tempInt = tempInt / 256;
			  	tempInt = tempInt % 256;
			  	SendBuff[8] = (byte)tempInt;

				//Get complement of pVal
			  	SendBuff[9]  = (byte)(255 - SendBuff[5]);
				SendBuff[10] = (byte)(255 - SendBuff[6]);
			  	SendBuff[11] = (byte)(255 - SendBuff[7]);
				SendBuff[12] = (byte)(255 - SendBuff[8]);
		    }
		    else
		    {
		    	tempLong = abs(pVal);
		    	
				//Computation of pVal
			  	SendBuff[5] = (byte)~(tempInt + 1);
			  	SendBuff[9] = (byte) (tempInt - 1);

			  	tempInt = (int) tempLong / 256;
			  	tempInt = tempInt % 256;
			  	SendBuff[6] = (byte) ~(tempInt);
		  		SendBuff[10] =(byte)tempInt;

			  	tempInt = (byte) (tempLong / 256);
			  	tempInt = tempInt / 256;
			  	tempInt = tempInt % 256;
			  	SendBuff[7] = (byte) ~(tempInt);
			  	SendBuff[11] =(byte)tempInt;

			  	tempInt = (byte)(tempLong / 256);
			   	tempInt = tempInt / 256;
			  	tempInt = tempInt / 256;
			  	tempInt = tempInt % 256;
				SendBuff[8] = (byte) ~(tempInt);
			  	SendBuff[12] = (byte)tempInt;
		    	
		    }
		    
		    SendBuff[13] = SendBuff[5];
			SendBuff[14] = SendBuff[6];
			SendBuff[15] = SendBuff[7];
			SendBuff[16] = SendBuff[8];

			SendBuff[17] = SendBuff[4];
			SendBuff[18] = (byte)(255 - SendBuff[4]);
			SendBuff[19] = SendBuff[4];
			SendBuff[20] = (byte)(255 - SendBuff[4]);
			
			SendLen = 21;
			RecvLen[0] = 255;
			
			retCode = sendAPDUandDisplay();
			
			if(retCode == 0)
			{
				displayOut( 0, 0, "Store value from block " + tValBlock.getText() + " success");
			}
			else
			{
				displayOut( 1, 0, "Store value from block " + tValBlock.getText() + " failed");
			}		
		}
		
		if(bValRead == e.getSource())
		{		
			
			if(tValBlock.getText().length() == 0)
			{
				tValBlock.requestFocus();
				return;
			}
			
			clearBuffers();
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0x30;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
		    
		    SendLen = 5;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		    
		    if(retCode == 0)
		    {
		    	tempInt = (RecvBuff[3] & 0xFF);
		    	tempInt = (tempInt + ((RecvBuff[4] & 0xFF) * 256));
		    	tempInt = (tempInt + ((RecvBuff[5] & 0xFF) * 256 * 256));
		    	tempInt = (tempInt + ((RecvBuff[6] & 0xFF) * 256 * 256 * 256));
		    	
		    	   	
		    	tValAmount.setText("" + tempInt);
		    	
		    	displayOut( 0, 0, "Read value from block " + tValBlock.getText() + " success");
		    	
		    }
		    else
		    {
		    	displayOut( 0, 0, "Read value from block " + tValBlock.getText() + " failed");
		    }
		    	
			
		}
		
		if(bValInc == e.getSource())
		{
			
			if(tValAmount.getText().length() == 0)
			{
				tValAmount.requestFocus();
				return;
			}
			
			if(tValBlock.getText().length() == 0)
			{
				tValBlock.requestFocus();
				return;
			}
			
			clearBuffers();
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0xC1;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
		    
		  //Computation of the increment value
		    tempInt = Integer.parseInt(tValAmount.getText());

		    tempLong = tempInt % 256;
		  	SendBuff[5] = (byte) tempLong;

		  	tempLong = tempInt / 256;
		  	tempLong = tempLong % 256;
			SendBuff[6] = (byte) tempLong;

			tempLong = tempInt / 256;
			tempLong = tempLong / 256;
			tempLong = tempLong % 256;
		  	SendBuff[7] = (byte) tempLong;

		  	tempLong = tempInt / 256;
		  	tempLong = tempLong / 256;
		  	tempLong = tempLong / 256;
		  	tempLong = tempLong % 256;
		  	SendBuff[8] = (byte) tempLong;

		    SendLen = 9;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		   
		    if(retCode == 0)
		    {
		    	clearBuffers();
		    	SendBuff[0] = (byte) 0xD4;
			    SendBuff[1] = (byte) 0x40;
			    SendBuff[2] = (byte) 0x01;
			    SendBuff[3] = (byte) 0xB0;
			    
			    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
			    
			    SendLen = 5;
			    RecvLen[0] = 255;
			    
			    retCode = sendAPDUandDisplay();
			    
			    if(retCode == 0)
			    {
			    	displayOut( 0, 0, "Increment value from block " + tValBlock.getText() + " success");
			    }
			    else
			    {
			    	displayOut( 1, 0, "Increment value from block " + tValBlock.getText() + " failed");
			    }
			    
		    	
		    }
		    else
		    {
		    	displayOut( 1, 0, "Increment value from block " + tValBlock.getText() + " failed");
		    }
		    
		}
		
		if(bValDec == e.getSource())
		{
			
			if(tValAmount.getText().length() == 0)
			{
				tValAmount.requestFocus();
				return;
			}
			
			if(tValBlock.getText().length() == 0)
			{
				tValBlock.requestFocus();
				return;
			}
			
			clearBuffers();		
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0xC0;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
		    
			  //Computation of the decrement value
		    tempInt = Integer.parseInt(tValAmount.getText());

		    tempLong = tempInt % 256;
		  	SendBuff[5] = (byte) tempLong;

		  	tempLong = tempInt / 256;
		  	tempLong = tempLong % 256;
			SendBuff[6] = (byte) tempLong;

			tempLong = tempInt / 256;
			tempLong = tempLong / 256;
			tempLong = tempLong % 256;
		  	SendBuff[7] = (byte) tempLong;

		  	tempLong = tempInt / 256;
		  	tempLong = tempLong / 256;
		  	tempLong = tempLong / 256;
		  	tempLong = tempLong % 256;
		  	SendBuff[8] = (byte) tempLong;

		    SendLen = 9;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		    
		    if(retCode == 0)
		    {
		    	clearBuffers();
		    	SendBuff[0] = (byte) 0xD4;
			    SendBuff[1] = (byte) 0x40;
			    SendBuff[2] = (byte) 0x01;
			    SendBuff[3] = (byte) 0xB0;
			    
			    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValBlock.getText(), 16)).byteValue();
			    
			    SendLen = 5;
			    RecvLen[0] = 255;
			    
			    retCode = sendAPDUandDisplay();
			    
			    if(retCode == 0)
			    {
			    	displayOut( 0, 0, "Decrement value from block " + tValBlock.getText() + " success");
			    }
			    else
			    {
			    	displayOut( 1, 0, "Decrement value from block " + tValBlock.getText() + " failed");
			    }
		    	
		    }
		    else
		    {
		    	displayOut( 1, 0, "Decrement value from block " + tValBlock.getText() + " failed");
		    }
			
		}
		
		if(bValCopy == e.getSource())
		{
			if(tValTarget.getText().length() == 0)
			{
				tValTarget.requestFocus();
				return;
			}
			
			if(tValSrc.getText().length() == 0)
			{
				tValSrc.requestFocus();
				return;
			}
			
			
			if((Integer.parseInt(tValTarget.getText())) < 0x80)
			{
				retCode = JOptionPane.showConfirmDialog( null, "Critical block chosen to be written. Continue?", "Warning", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
				
				if(retCode == JOptionPane.NO_OPTION)
					return;
			}
			
			if(((Integer.parseInt(tValTarget.getText())) - 128) % 4 == 3)
			{
				retCode = JOptionPane.showConfirmDialog( null, "Critical block chosen to be written. Continue?", "Warning", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
				
				if(retCode == JOptionPane.NO_OPTION)
					return;
			}
			
			clearBuffers();
			
			SendBuff[0] = (byte) 0xD4;
		    SendBuff[1] = (byte) 0x40;
		    SendBuff[2] = (byte) 0x01;
		    SendBuff[3] = (byte) 0xC2;
		    
		    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValSrc.getText(), 16)).byteValue();
		    
		    SendLen = 5;
		    RecvLen[0] = 255;
		    
		    retCode = sendAPDUandDisplay();
		    
		    if(retCode == 0)
		    {
		    	clearBuffers();
				
				SendBuff[0] = (byte) 0xD4;
			    SendBuff[1] = (byte) 0x40;
			    SendBuff[2] = (byte) 0x01;
			    SendBuff[3] = (byte) 0xB0;
			    
			    SendBuff[4] = (byte) ((Integer)Integer.parseInt(tValTarget.getText(), 16)).byteValue();
			    
			    SendLen = 5;
			    RecvLen[0] = 255;
			    
			    retCode = sendAPDUandDisplay();
			    
			    if(retCode == 0)
			    {
			    	displayOut( 0, 0, "Copying value to block " + tValTarget.getText() + " success");
			    	
			    }
			    else
			    {
			    	displayOut( 1, 0, "Copy block failed");
			    }
			    
		    }
		    else
		    {
		    	displayOut( 1, 0, "Copy block failed");
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
			displayOut( 0, 0, "Program Ready");
			
			tKey1.setText("");
			tKey2.setText("");
			tKey3.setText("");
			tKey4.setText("");
			tKey5.setText("");
			tKey6.setText("");
			tValAmount.setText("");
			tValBlock.setText("");
			tValSrc.setText("");
			tValTarget.setText("");
			tBinBlock.setText("");
			tData.setText("");
			tBlkNo.setText("");
			
			
			
			enableAll(false);
		}
		
		if(bQuit == e.getSource())
		{
			if(connActive == true)
			{
				acr122.jACR122_Close(hReader);
			}
			this.dispose();		
		}
		
		if(rTypea == e.getSource())
		{
			rTypea.setSelected(true);
			rTypeb.setSelected(false);
		}
		
		if(rTypeb == e.getSource())
		{
			rTypea.setSelected(false);
			rTypeb.setSelected(true);
		}
		
		
		
	
				
	}
	
	public int abs(int num)
	{
		num = num - num - num;
		
		return num;
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
	
	public void clearBuffers()
	{
		
		for(int i=0; i<255; i++)
		{
			
			SendBuff[i]=(byte) 0x00;
			RecvBuff[i]= (byte) 0x00;
			
		}
		
	}
	
	public int checkAuthInput()
	{
		if(tBlkNo.getText().equals(""))
		{
			tBlkNo.requestFocus();
			return 1;
		}
		
		if(tKey1.getText().equals(""))
		{
			tKey1.requestFocus();
			return 1;
		}
		
		if(tKey2.getText().equals(""))
		{
			tKey2.requestFocus();
			return 1;
		}
		
		if(tKey3.getText().equals(""))
		{
			tKey3.requestFocus();
			return 1;
		}
		
		if(tKey4.getText().equals(""))
		{
			tKey4.requestFocus();
			return 1;
		}
		
		if(tKey5.getText().equals(""))
		{
			tKey5.requestFocus();
			return 1;
		}
		
		if(tKey6.getText().equals(""))
		{
			tKey6.requestFocus();
			return 1;
		}
		
		
		
		
		return 0;
	}
	
	public void displayOut(int mType, int msgCode, String printText)
	{
		switch(mType)
		{
		
			case 1: mMsg.append("! " + printText + "\n"); break;
			case 2: mMsg.append("< " + printText + "\n");break;
			case 3: mMsg.append("> " + printText + "\n");break;
			default: mMsg.append("- " + printText + "\n");
		
		}
		
	}
	
	public void initMenu()
	{	
		connActive = false;
		
		bConn.setEnabled(true);
		enableAll(false);
			
		displayOut(0, 0, "Program Ready");
		
	}
	
	public void enableAll(boolean enable){
		
		bReset.setEnabled(enable);
		rTypea.setEnabled(enable);
		rTypeb.setEnabled(enable);
		tBlkNo.setEnabled(enable);
		tKey1.setEnabled(enable);
		tKey2.setEnabled(enable);
		tKey3.setEnabled(enable);
		tKey4.setEnabled(enable);
		tKey5.setEnabled(enable);
		tKey6.setEnabled(enable);
		bAuth.setEnabled(enable);
		tBinBlock.setEnabled(enable);
		tData.setEnabled(enable);
		bRead.setEnabled(enable);
		bUpdate.setEnabled(enable);
		tValAmount.setEnabled(enable);
		tValBlock.setEnabled(enable);
		tValSrc.setEnabled(enable);
		tValTarget.setEnabled(enable);
		bValStore.setEnabled(enable);
		bValRead.setEnabled(enable);
		bValInc.setEnabled(enable);
		bValDec.setEnabled(enable);
		bValCopy.setEnabled(enable);
		
		
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
  		if(tBlkNo.isFocusOwner() || tBinBlock.isFocusOwner() || tValAmount.isFocusOwner() || tValSrc.isFocusOwner() || tValBlock.isFocusOwner() || tValTarget.isFocusOwner())
  		{	
  		
  			if (VALIDCHARS.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);
  			
  		}
  		else
  		{
  			
  			if (VALIDCHARSHEX.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);
  			
  		}
  					  
		//Limit character length
  		if(tBlkNo.isFocusOwner() || tBinBlock.isFocusOwner() || tValBlock.isFocusOwner() || tValSrc.isFocusOwner() || tValTarget.isFocusOwner())
  		{
  			
  			if   (((JTextField)ke.getSource()).getText().length() >= 3 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
  		else if(tValAmount.isFocusOwner())
  		{
  			
  			if   (((JTextField)ke.getSource()).getText().length() >= 10 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
  		else
  		{
  			
  			if   (((JTextField)ke.getSource()).getText().length() >= 2 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
  	    	
	}
    
    public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new mainMifareProg().setVisible(true);
            }
        });
    }



}
