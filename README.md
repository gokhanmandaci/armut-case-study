# Armut - iOS Developer - Case Study
### Gökhan Mandacı
### 23 Oct 2021

I developed a two-page app for the Armut-Case Study. On the first page, I provided the display of All Services(Home) with the UI given in the case. On the second page, I showed the detail information of a specific service. In the main page, the blog posts are presented by using the Safari View Controller. I did not add the tabs and the search field as it was written in the case document.

I used the assets given in the Case. First, I converted the svg to png, but I used it as svg on the detail page, thinking maybe you expect such use.

Since time was enough, I added some animations to make the UI/UX more appealing. I kept the default dark mode enabled. I also created color sets in order to keep the look beautiful in dark mode. For iPad, I have achieved compatibility by using compact sizes and adding a few controls within the code.

- Developed with Swift language.
- I used XCode 13.0
- iPhone and iPad compatible.
- I developed iOS 15+ compatible. I didn't support old versions which need adding extra controls (for example for navigation bar) but it is easily adaptable.
- Developed with MVVM architecture.
- Except for dynamic areas, I used autolayout and storyboard in the design.
- I wanted to add a few tests that can serve as an example for test writing, which I know is one of the main focus points that I need to develop for myself.

I spent time on the questions in the bonus section. 
+ I used cache to speed up the loading time of the photos. I used KingFisher's cache mechanism. It is designed with an auto purge ability and with a Greedy algorithm. Even if the app is killed after the load, we do not lose the cache because it also saves to the disk. I used it with default memory usage.
+ Assets used inside the app can be compressed.
+ In addition, in cases where the images coming from the server side have different sizes, on the fly resize can be done according to the usage area.
+ In terms of UX, we can start with blurred images while loading and then update to clear later.


+ For scroll performance, first thing I thinked about is making main thread as free as possible. 
+ I made the assignments in cell subclasses to increase scroll performance. 
+ In addition, I made the shadows on the images at the CALayer level and rasterized them in the animating header. 
+ By keeping the "cell for row at" and "item at indexpath" functions simple, I tried to keep the constantly triggered places less burdened. 
+ Also avoiding alpha channels as much as we can helps scroll performance. So I tried to use opaque colors.
+ I used leak profiling tool to catch leaks which have a negative effect on scroll performance.

Cocoapods: </br>
  'Moya' - Networking abstraction layer based over Alamofire </br>
  'Kingfisher' - Image download and caching </br>
  'SVProgressHUD' - Loading View </br>
  'SwiftSVG' - Used for svg images. </br>
  'Hero' - Smooth animations for popular posts </br>
  'CocoaDebug' - Check network calls in real time. </br>
