//
//  ShareViewController.swift
//  StdTxGuide
//
//  Created by Greg Ledbetter on 12/18/15.
//  Copyright © 2015 jtq6. All rights reserved.
//

import UIKit
import MessageUI
import Social




class ShareViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    var sc = SiteCatalystService()

    let shareText = "I’m using CDC’s STD Tx Guide mobile app. Learn more about it here:"
    let shareUrl = "http://www.cdc.gov/std/tg2015/"
    let shareImage = UIImage(named: "AppIcon")
    

    @IBOutlet weak var webView: UIWebView!
    @IBAction func btnEmailShareTouchUp(sender: AnyObject) {
        
        let mailComposeViewController = self.configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: {() in
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
            })
        } else {
            self.showSendMailErrorAlert()
            
        }
    }
    
    @IBAction func btnMessageShareTouchUp(sender: AnyObject) {
        
        let mailComposeViewController = self.configuredMessageComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: {() in
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
            })
        } else {
            self.showSendMailErrorAlert()
            
        }
    }

    @IBAction func btnFacebookShareTouchUp(sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText(shareText)
        vc.addImage(shareImage)
        vc.addURL(NSURL(string: shareUrl))
        presentViewController(vc, animated: true, completion: nil)

    }

    @IBAction func btnTwitterShareTouchUp(sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc.setInitialText(shareText)
        vc.addImage(shareImage)
        vc.addURL(NSURL(string: shareUrl))
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSBundle.mainBundle().URLForResource("share", withExtension: "html")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
     
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_SHARE, section: sc.SC_SECTION_SHARE)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("STD Tx Guide App from CDC")
        let messageBody = String(format:"\n %@ \n %@",shareText, shareUrl)
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        
        return mailComposerVC
    }

    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        
        let messageComposerVC = MFMessageComposeViewController()
        messageComposerVC.messageComposeDelegate = self
        messageComposerVC.body = String(format:"%@ \n%@",shareText, shareUrl)
        
        return messageComposerVC
    }
    

    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
