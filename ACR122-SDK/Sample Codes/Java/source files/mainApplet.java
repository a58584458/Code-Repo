
import java.awt.event.*;
import javax.swing.*;
import javax.swing.JApplet;

public class mainApplet extends JApplet implements ActionListener
{

	//Variables
	boolean openGetATR=false, openPolling=false, openMifare=false, openOtherPICC=false, openDevProg=false, openSAM=false;
	
    private JButton bDevProg;
    private JButton bGetATR;
    private JButton bMifare;
    private JButton bOtherPICC;
    private JButton bPolling;
    private JButton bSAM;
    private JLabel lblSampleCode;
    
    static GetATR getATR;
    static Polling poll;
    static mainMifareProg mifare;
    static PICCCardProg otherPICC;
    static DeviceProgramming devProg;
    static KeyManage keyMgt;
    

    public void init() {

    	setSize(200,230);
    	
        lblSampleCode = new JLabel();
        bGetATR = new JButton();
        bPolling = new JButton();
        bMifare = new JButton();
        bOtherPICC = new JButton();
        bDevProg = new JButton();
        bSAM = new JButton();

        lblSampleCode.setHorizontalAlignment(SwingConstants.CENTER);
        lblSampleCode.setText("ACR122S Sample Codes");

        bGetATR.setText("Get ATR");

        bPolling.setText("Polling");

        bMifare.setText("Mifare 1K 4K");

        bOtherPICC.setText("Other PICC Cards");

        bDevProg.setText("Device Programming");
        
        bSAM.setText("Key Management");

        GroupLayout layout = new GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(GroupLayout.Alignment.LEADING)
                    .addComponent(lblSampleCode, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bGetATR, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bPolling, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bMifare, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bOtherPICC, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bSAM, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE)
                    .addComponent(bDevProg, GroupLayout.DEFAULT_SIZE, 146, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblSampleCode, GroupLayout.PREFERRED_SIZE, 14, GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED, 15, Short.MAX_VALUE)
                .addComponent(bDevProg)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bGetATR)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bPolling)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bMifare)
                .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bOtherPICC)
                 .addPreferredGap(LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(bSAM)
                .addGap(27, 27, 27))
        );
        
        bGetATR.addActionListener(this);
        bMifare.addActionListener(this);
        bPolling.addActionListener(this);
        bDevProg.addActionListener(this);
        bOtherPICC.addActionListener(this);
        bSAM.addActionListener(this);
        
    }

    public void actionPerformed(ActionEvent e) {
    	
    	if(e.getSource() == bGetATR)
    	{
    		closeFrames();
			
			if(openGetATR == false)
			{
				getATR = new GetATR();
				getATR.setVisible(true);
				openGetATR = true;
			}
			else
			{
				getATR.dispose();
				getATR = new GetATR();
				getATR.setVisible(true);
				openGetATR = true;
			}
    	}
    	
    	if(e.getSource() == bPolling)
    	{
    		closeFrames();
			
			if(openPolling == false)
			{
				poll = new Polling();
				poll.setVisible(true);
				openPolling = true;
			}
			else
			{
				poll.dispose();
				poll = new Polling();
				poll.setVisible(true);
				openPolling = true;
			}
    	}
    	
    	if(e.getSource() == bMifare)
    	{
    		closeFrames();
			
			if(openMifare == false)
			{
				mifare = new mainMifareProg();
				mifare.setVisible(true);
				openMifare = true;
			}
			else
			{
				mifare.dispose();
				mifare = new mainMifareProg();
				mifare.setVisible(true);
				openMifare = true;
			}
    	}
    	
    	if(e.getSource() == bOtherPICC)
    	{
    		closeFrames();
			
			if(openOtherPICC == false)
			{
				otherPICC = new PICCCardProg();
				otherPICC.setVisible(true);
				openOtherPICC = true;
			}
			else
			{
				otherPICC.dispose();
				otherPICC = new PICCCardProg();
				otherPICC.setVisible(true);
				openOtherPICC = true;
			}
    	}
    	
    	if(e.getSource() == bDevProg)
    	{
    		closeFrames();
			
			if(openDevProg == false)
			{
				devProg = new DeviceProgramming();
				devProg.setVisible(true);
				openDevProg = true;
			}
			else
			{
				devProg.dispose();
				devProg = new DeviceProgramming();
				devProg.setVisible(true);
				openDevProg = true;
			}
    	}
    	
    	if(e.getSource() == bSAM)
    	{
    		closeFrames();
			
			if(openSAM == false)
			{
				keyMgt = new KeyManage();
				keyMgt.setVisible(true);
				openSAM = true;
			}
			else
			{
				keyMgt.dispose();
				keyMgt = new KeyManage();
				keyMgt.setVisible(true);
				openSAM = true;
			}
    	}
    	
    }
    
    public void closeFrames()
	{
		if(openGetATR==true)
		{
			getATR.dispose();
			openGetATR = false;
		}
		
		if(openPolling==true)
		{
			poll.dispose();
			openPolling = false;
		}
		
		if(openMifare==true)
		{
			mifare.dispose();
			openMifare = false;
		}
		
		if(openOtherPICC==true)
		{
			otherPICC.dispose();
			openOtherPICC = false;
		}
		
		if(openDevProg==true)
		{
			devProg.dispose();
			openDevProg = false;
		}
		
		if(openSAM==true)
		{
			keyMgt.dispose();
			openSAM = false;
		}
		
	}

    public void start(){}
}