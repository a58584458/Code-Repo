/*
  Copyright(C):      Advanced Card Systems Ltd

  File:              Dialog.java

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

public class Dialog extends JFrame implements ActionListener, KeyListener{

	static String VALIDCHARS = "0123456789";
	
	int retCode;
	
    private java.awt.Button bCancel;
    private java.awt.Button bOk;
    private JLabel jLabel1;
    private JLabel jLabel2;
    private JLabel jLabel3;
    private JLabel jLabel4;
    private JTextField tbRespRe;
    private JTextField tbRespTO;
    private JTextField tbStatRe;
    private JTextField tbStatTO;

    public Dialog() {
    	
    	this.setTitle("Dialog");
        initComponents();
        initMenu();
        
    }
    
    public void initMenu(){
    	tbStatTO.setText("2000");
    	tbStatRe.setText("1");
    	tbRespTO.setText("10000");
    	tbRespRe.setText("1");
    }
	
    private void initComponents() {
    	
    	Image icon = Toolkit.getDefaultToolkit().getImage("ACS_multiple.PNG");
    	
    	this.setIconImage(icon);
    	
    	setSize(250, 200);
    	
    	//sets the location of the form at the center of screen
   		Dimension dim = getToolkit().getScreenSize();
   		Rectangle abounds = getBounds();
   		setLocation((dim.width - abounds.width) / 2, (dim.height - abounds.height) / 2);
   		requestFocus();
   		
    	jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        tbStatTO = new javax.swing.JTextField();
        tbStatRe = new javax.swing.JTextField();
        tbRespTO = new javax.swing.JTextField();
        tbRespRe = new javax.swing.JTextField();
        bOk = new java.awt.Button();
        bCancel = new java.awt.Button();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setName("Form"); 

        
        jLabel1.setText("Status Timeout (ms):"); 
        jLabel1.setName("jLabel1"); 

        jLabel2.setText("Status Retries"); 
        jLabel2.setName("jLabel2"); 

        jLabel3.setText("Response Timeout (ms):"); 
        jLabel3.setName("jLabel3"); 

        jLabel4.setText("Response Retries"); 
        jLabel4.setName("jLabel4"); 

        tbStatTO.setText(""); 
        tbStatTO.setName("tbStatTO"); 

        tbStatRe.setText(""); 
        tbStatRe.setName("tbStatRe"); 

        tbRespTO.setText(""); 
        tbRespTO.setName("tbRespTO"); 

        tbRespRe.setText(""); 
        tbRespRe.setName("tbRespRe"); 

        bOk.setLabel("Ok"); 
        bOk.setName("bOk"); 

        bCancel.setLabel("Cancel"); 
        bCancel.setName("bCancel"); 

       
        
        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel3)
                    .addComponent(jLabel4)
                    .addComponent(jLabel2)
                    .addComponent(jLabel1)
                    .addComponent(bOk, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(tbStatTO)
                        .addComponent(tbStatRe)
                        .addComponent(tbRespTO, javax.swing.GroupLayout.Alignment.TRAILING)
                        .addComponent(tbRespRe, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 70, Short.MAX_VALUE))
                    .addComponent(bCancel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(341, 341, 341))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(tbStatTO, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(tbStatRe, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(tbRespTO, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(tbRespRe, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(bOk, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, 200)
                    .addComponent(bCancel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, 200))
                .addContainerGap(36, Short.MAX_VALUE))
        );
        
        bOk.addActionListener(this);
        bCancel.addActionListener(this);
    
        tbStatTO.addKeyListener(this);
        tbStatRe.addKeyListener(this);
        tbRespTO.addKeyListener(this);
        tbRespRe.addKeyListener(this);
        
    }
	
	public void actionPerformed(ActionEvent e) {
	

		ACR122_TIMEOUTS acrTO = new ACR122_TIMEOUTS();
		
		
		if(bOk == e.getSource())
		{
			if(tbStatTO.getText().length() == 0)
			{
				tbStatTO.requestFocus();
				return;
			}
			
			if(tbStatRe.getText().length() == 0)
			{
				tbStatRe.requestFocus();
				return;
			}
			
			if(tbRespTO.getText().length() == 0)
			{
				tbRespTO.requestFocus();
				return;
			}
			
			if(tbRespRe.getText().length() == 0)
			{
				tbRespRe.requestFocus();
				return;
			}
			
			acrTO.statusTimeout = Integer.parseInt(tbStatTO.getText());
			acrTO.numStatusRetries = Integer.parseInt(tbStatRe.getText());
			acrTO.responseTimeout = Integer.parseInt(tbRespTO.getText());
			acrTO.numResponseRetries = Integer.parseInt(tbRespRe.getText());
			
			retCode = DeviceProgramming.acr122.jACR122_SetTimeouts(DeviceProgramming.hReader, acrTO);
			
			if(retCode == 0)
			{
				DeviceProgramming.displayOut( 0, 0, "Set Timeouts success");
			}
			else
			{
				DeviceProgramming.displayOut( 1, 0, "Set Timeouts failed");
			}
			
			this.dispose();
			
				
		}
		
		if(bCancel == e.getSource())
		{
			this.dispose();		
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
  		if(tbStatTO.isFocusOwner() || tbStatRe.isFocusOwner() || tbRespTO.isFocusOwner() || tbRespRe.isFocusOwner())
  		{	
  		
  			if (VALIDCHARS.indexOf(x) == -1 ) 
  				ke.setKeyChar(empty);
  			
  		}
  		
  					  
		//Limit character length
  		if(tbStatTO.isFocusOwner() || tbStatRe.isFocusOwner() || tbRespTO.isFocusOwner() || tbRespRe.isFocusOwner())
  		{
  			
  			if(((JTextField)ke.getSource()).getText().length() >= 10 ) 
  			{
		
  				ke.setKeyChar(empty);	
  				return;
  				
  			}
  			
  		}
	    	
	}
	
}
