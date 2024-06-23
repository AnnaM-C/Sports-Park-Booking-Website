# Sports Park Booking Website

The purpose of the website I have created for my coursework is to enable sports park members to view their booking
information and personal details on an account page interface. From here, a member can choose and add
additional gym classes bookings to their account.

The file account.php accesses the MySQL database and it is the starting file for the website. It enables a sports park member
to enter their unique member ID (member ID example: MBX4329873) into the search form which, when clicked, will trigger
a connection to the database and send a number of SQL queries to the database to retrieve the member’s details from the
database. As a result, details such as the members first and last name, membership type (ie Gold, Silver or Bronze),
emergency contact first and last name, total number of gym classes booked that week, a breakdown of classes booked
that week and the total number of classes at class name level and the time and day of the booked class, will be displayed
under the search button.

Additionally, when the search button is clicked, the member’s ID is stored as a cookie. The purpose of the
cookie is to store the member’s ID so that if a member clicks on ‘Add Booking’ the member is taken to a second page,
manage_bookings.php, and on this second page the cookie stores the member’s ID so the member will not
have to add their ID a second time to book a class. This is a better experience for the member and then the class they
choose to book is stored in the database against their member ID.

The manage_bookings.php file also accesses the MySQL database. A member can choose any class available from the
dropdown option. When a class is selected and searched for, a connection to the database is established and an SQL query
will retrieve the date and time of the selected activity which is based on the class ID. The query returns date and time
values for the specific class and these values are displayed as a checkbox form underneath the search button on the page.
The selected class time and date is now available on the page for the member to select. A member can
make multiple bookings. To avoid a member booking the same class twice, the code is set up to allow a member to book
the class only once. A “You have already booked this class” message will appear if the class has been booked already. A
“Class was successfully added to your account” message will appear if the class is added to the members account
successfully.

JavaScript has been used on the first website page, account.php. The purpose of the JavaScript is to, when the search
button is clicked, add the CSS transition property to the member details so the member details gently appear to ease in on
the page after 1 second which provides an engaging experience for the member.

I have used Bootstrap’s CSS template and I have provided the reference in Section 7 References. I have also added my
own CSS styling in the style.css file, to edit text and images. I have linked the scripts to both account.php and
manage_bookings.php pages
