# CS329E_FinalProject
Shared grocery list iOS app by Shreya, Emily, Jennifer, and Samira (CS329E)

<!-- Output copied to clipboard! -->

<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 1.329 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β33
* Mon Dec 05 2022 19:03:23 GMT-0800 (PST)
* Source doc: CS 329E Final Project ReadMe File 
* Tables are currently converted to HTML tables.
----->


**Name of Project: **GroceriesForU

**Team Members: **Emily Wang, Jennifer Lin, Samira Ravilisetty, Shreya Kumaran 

**Dependencies: **Xcode version 14.0.1, Swift version 5, Firebase version 9.0.0

**Special Instructions: **



* Use an iPhone 14 Pro Simulator 
* When adding items to the calculator, make sure to hit enter after adding in the price to have those values included in the sum when pressing calculate 
* Use this test account for logging in: 

    Email: [user2@test.com](mailto:user2@test.com)


    Password: 123456


**Required Feature Checklist: **



1. Login/register path with Firebase 
2. Settings Screen. The three behaviors we implemented are Sound Alerts, Notifications, Dark Mode
3. Non-default fonts and colors used 

Two Major elements used: 



1. Core Data- On home page, the items added to the grocery list are stored even when closing out of the app  
2. User profile path using camera and photo library- can change the profile picture using the live camera or from a photo library  

 

Minor Elements used: 



1. Three additional view types including segmented controllers and bar buttons (bar buttons are used in the tab bar at the bottom of the screen and the segmented controller is used to switch between the login and the create account page, switches used on the settings page)
2. Table View- the table view is used on the home page to display the grocery list items and their respective quantities
3. Alerts, Scroll Views, and User defaults- alerts the user when an item is successfully added to the grocery list and a scroll view is used to display the quick add items to the grocery list. User defaults are used in the settings page. 
4. Frameworks Implemented: Local notifications (the user can turn on local notifications for when an item is added to the grocery list), Gesture Recognition (when the keyboard is open on the screen, user can tap to close it), Animation (the logo on the get started page slides in from the right), Core Audio (when the setting is turned on, adding an item to the grocery list creates a sound)

**Work Distribution Table **


<table>
  <tr>
   <td><strong>Required Feature</strong>
   </td>
   <td><strong>Description</strong>
   </td>
   <td><strong>Who / Percentage worked on </strong>
   </td>
  </tr>
  <tr>
   <td>Login / Register 
   </td>
   <td>Allows user to create account and login 
   </td>
   <td>Shreya (100%)
   </td>
  </tr>
  <tr>
   <td>UI Design 
   </td>
   <td>Designed wireframe for app and selected colors and fonts 
   </td>
   <td>Jennifer (100%)
   </td>
  </tr>
  <tr>
   <td>Settings
   </td>
   <td>Allows user to change profile pictures, name and logout 
   </td>
   <td>Jennifer (100%) 
   </td>
  </tr>
  <tr>
   <td>Profile path
   </td>
   <td>Allow user to edit user profile and change profile picture using camera and photo library 
   </td>
   <td>Samira (80%)
<p>
Shreya (20%)
   </td>
  </tr>
  <tr>
   <td>Calculator  
   </td>
   <td>Allows the user to add the name of the item and the price to the calculator. When the calculate button is pressed, the sum is calculated and displayed. 
   </td>
   <td>Emily (100%)
   </td>
  </tr>
  <tr>
   <td>Home 
   </td>
   <td>Uses core data to display items added to the grocery list
   </td>
   <td>Samira (90%)
<p>
Emily (10%)
   </td>
  </tr>
</table>

