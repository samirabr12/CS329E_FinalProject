Name of Project: **GroceriesForU**

Team Members: **Emily Wang, Jennifer Lin, Samira Ravilisetty, Shreya Kumaran**

Dependencies: **Xcode version 14.0.1, Swift version 5, Firebase version 9.0.0**

**Special Instructions:**



* Use an iPhone 14 Pro Simulator 
* When adding items to the calculator, make sure to hit enter after adding in the price to have those values included in the sum when pressing calculate 
* Use this test account for logging in: 

    Email: [user2@test.com](mailto:user2@test.com)


    Password: 123456


**Required Feature Checklist:**



1. Login/register path with Firebase 
2. Settings Screen. The three behaviors we implemented are Sound Alerts, Notifications, Dark Mode  
3. Non-default fonts and colors used 
4. For Grocery List (TableView) - swiping from left to right allows you to edit an item and swiping from right to left allows you to delete an item
5. Calculator - Can edit calculation by changing text inputs, can delete calculation by swiping right to left, and can confirm reset of calculation with reset button

Two Major elements used: 



1. Core Data- On home page, the items added to the grocery list are stored even when closing out of the app  
2. User profile path using camera and photo library- can change the profile picture using the live camera or from a photo library  

 

Minor Elements used: 



1. Three additional view types including segmented controllers and bar buttons (bar buttons are used in the tab bar at the bottom of the screen and the segmented controller is used to switch between the login and the create account page, switches used on the settings page)
2. Table View- the table view is used on the home page to display the grocery list items and their respective quantities
3. Alerts, Scroll Views, and User defaults- alerts the user when an item is successfully added to the grocery list and a scroll view is used to display the quick add items to the grocery list. User defaults are used in the settings page to save switch state even when switching between VCs. 
4. Frameworks Implemented: Local notifications (the user can turn on local notifications for when an item is added to the grocery list), Gesture Recognition (when the software keyboard is open on the screen, user can tap to close it), Animation (the logo on the get started page slides in from the right), Core Audio (when the setting is turned on, adding an item to the grocery list creates a sound)

**Work Distribution Table**


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
   <td>Allows user to turn on/off notifications, sound, and dark mode
   </td>
   <td>Jennifer (60%) 
<p>
Shreya (40%)
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
   <td>Emily (80%)
<p>
Jennifer (10%)
<p>
Samira (10%)
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
  <tr>
   <td>Add New Item
   </td>
   <td>Add new items to the grocery list. You can add a recommended item or a custom item.
   </td>
   <td>Samira (50%)
<p>
Jennifer (50%)
   </td>
  </tr>
</table>

