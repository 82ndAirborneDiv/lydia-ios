//
//  SupportViewController.swift
//  StdTxGuide
//
//  Created by Greg Ledbetter on 12/1/15.
//  Copyright © 2015 jtq6. All rights reserved.
//

import UIKit
import MessageUI



class SupportViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var sc = SiteCatalystService()

    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func btnEmailSupportTouchUp(_ sender: AnyObject) {
        
        let mailComposeViewController = self.configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: {() in
                })
        } else {
            self.showSendMailErrorAlert()
            
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = Bundle.main.url(forResource: "support", withExtension: "html")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_SUPPORT, section: sc.SC_SECTION_SUPPORT)


    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property

        
        mailComposerVC.setToRecipients(["informaticslab@cdc.gov"])
        mailComposerVC.setSubject("App Support Request: STD Tx Guide for iOS")
        let messageBody = String(format:"\n\n\nApp name:  STD Tx Guide for iOS \nApp version:  %@  \nDevice model:  %@ \nSystem name:  %@ \nSystem version:  %@", DeviceInfo.getAppVersion(), DeviceInfo.getDeviceModel(), DeviceInfo.getDeviceSystemName(), DeviceInfo.getDeviceSystemVersion());
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {        
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message:"Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}

    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
