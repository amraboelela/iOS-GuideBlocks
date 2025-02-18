
## Using Circle Video GuideBlock

Everyone loves Circle Video! This is a simple example to get you started with Contextual Extensibility without needing to hard-code your changes every time you want to celebrate with the user.

1. Create an account at [Contextual Dashboard](https://dashboard.contextu.al/ "Contextual Dashboard").
2. Install the Contextual SDK following the instructions for IOS or Android.
3. Add `import iOS_GuideBlocks` usually in your AppDelegate.swift
4. Copy-Paste the instantiation of the Guide Component AFTER the Contextual SDK registration. e.g `Contextual.sharedInstance().registerGuideBlock(CircleVideoGuide(), forKey: "CircleVideo")`
5. Build your App and Run it on a phone or simulator
6. Go to the Dashboard and create a guide:
 * Use this [video]( https://vimeo.com/863886653#t=0m58s "Another Guide Creation How-to") to see the steps
 * choose “Display the guides on any screen of your app” and 
 * pick one of the “Standard” Contextual Announcement Templates.
 * Preview the Announcement on your Phone - it should look similar to the template
7. Now go to the Extensibility section in the sidebar and paste in the JSON as follows:
`
{
  "guideBlockKey": "CircleVideo"
}
`
 * Match the name in the JSON to the name of your wrapper in the code

 <img src="https://raw.githubusercontent.com/GuideBlocks-org/iOS-GuideBlocks/main/Sources/iOS-GuideBlocks/CircleVideo/circlevideo-guideblock.png" alt="Adding your Extra JSON" width="200"/>

8. If you are still in Preview Mode, then you should see the Announcement will magically change to CircleVideo.
9. Save the guide and show to your Product Team, once you release this version of the App they can launch Confetti to whoever they want, whenever they want.

