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
    @IBAction func btnEmailShareTouchUp(_ sender: AnyObject) {
        
        let mailComposeViewController = self.configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            mailComposeViewController.navigationBar.tintColor = UIColor.white
            self.present(mailComposeViewController, animated: true, completion: {() in
  //              UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: false)
            })
        } else {
            self.showSendMailErrorAlert()
            
        }
    }
    
    @IBAction func btnMessageShareTouchUp(_ sender: AnyObject) {
        
        let messageComposeViewController = self.configuredMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() {
            messageComposeViewController.navigationBar.tintColor = UIColor.white

            self.present(messageComposeViewController, animated: true, completion: {() in
            })
        } else {
            self.showSendMessageErrorAlert()
            
        }
    }

    @IBAction func btnFacebookShareTouchUp(_ sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc?.setInitialText(shareText)
        vc?.add(shareImage)
        vc?.add(URL(string: shareUrl))
        present(vc!, animated: true, completion: nil)

    }

    @IBAction func btnTwitterShareTouchUp(_ sender: AnyObject) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText(shareText)
        vc?.add(shareImage)
        vc?.add(URL(string: shareUrl))
        present(vc!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AppearanceHelper.setTranslucentNavBar(navigationController!.navigationBar)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = Bundle.main.url(forResource: "share", withExtension: "html")
        let request = URLRequest(url:url!)
        webView.loadRequest(request)
        self.view.backgroundColor = UIColor(red: 45.0/255.0, green: 88.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     
        super.viewWillAppear(animated)
        sc.trackNavigationEvent(sc.SC_PAGE_SHARE, section: sc.SC_SECTION_SHARE)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        mailComposerVC.setSubject("STD Tx Guide from CDC")
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
        
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message:"Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
    }

    func showSendMessageErrorAlert() {
        
        let sendMessageErrorAlert = UIAlertController(title: "Could Not Send Message", message:"Your device could not send message.", preferredStyle: .alert)
        sendMessageErrorAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(sendMessageErrorAlert, animated: true){}
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

}
