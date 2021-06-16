//
//  PageViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/15/21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    // MARK: Variables
    
    private let pageControllerViewModel = PageControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        createPageViewController()
    }
    

    func createPageViewController() {
        if pageControllerViewModel.getWeatherLocationTotal() > 0 {
            var contentController = getContentViewController(withIndex: pageControllerViewModel.getCurrentPage())!
            var contentControllers = [contentController]
            
            self.setViewControllers(contentControllers, direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    // create content view
    func getContentViewController(withIndex index: Int) -> ContentViewController? {
        if index < pageControllerViewModel.getWeatherLocationTotal() {
            var contentVC = self.storyboard?.instantiateViewController(withIdentifier: "contentVC") as! ContentViewController
            
            return contentVC
        }
        
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if pageControllerViewModel.getCurrentPage() > 0 {
            
            pageControllerViewModel.setPendingPage(page: pageControllerViewModel.getCurrentPage() - 1)
            print("left")
            print(PageManager.currentPage)
            print(PageManager.pendingIndex)
            return getContentViewController(withIndex: pageControllerViewModel.getCurrentPage() - 1)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if pageControllerViewModel.getCurrentPage() + 1 < pageControllerViewModel.getWeatherLocationTotal() {
            
            pageControllerViewModel.setPendingPage(page: pageControllerViewModel.getCurrentPage() + 1)
            print("right")
            print(PageManager.currentPage)
            print(PageManager.pendingIndex)
            return getContentViewController(withIndex: pageControllerViewModel.getCurrentPage() + 1)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("will transition")
        //pendingIndex = (pendingViewControllers.first as! ContentViewController).itemIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            var oldIndex = pageControllerViewModel.getCurrentPage()
            
            pageControllerViewModel.setCurrentPage(page: pageControllerViewModel.getPendingIndex())
            pageControllerViewModel.setPendingPage(page: oldIndex)
            print("did finish animating")
            print(PageManager.currentPage)
            print(PageManager.pendingIndex)
           
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sectionChanged"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshContent"), object: nil)
        }
    }
}
