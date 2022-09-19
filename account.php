<?php
//Set cookie using Form 2 data
        if(isset($_POST['submit1'])){
		    $search = htmlentities($_POST['search']);

		    setcookie('search', $search, time()+3600); // 1 Hour
        }

//Connect to database function
        function database() {
            if (isset($_POST['search'])) {

                $server = "localhost";
                $database = "Account";
                $username = "root";
                $password = "root";

                $connect = new mysqli($server, $username, $password, $database);

                if ($connect->connect_error) {
                    die("Failed Connection: " . $connect->connect_error);
                }
                if (isset($_POST['search']) && $query = $_POST['search']) {
                    search($connect, $query);
                } 
                                
                $connect->close();
            }
        }

//Search function to query database data
        function search($connect, $query) {
            $where = "(Member_Id LIKE '%$query%')";
            // SQL QUERY 1: Selects a members first name and last name from the Member table based on the member ID they entered into Form1. Form1 is on the account.php page.
            $sql = "SELECT Member_First_Name, Member_Last_Name FROM MEMBER WHERE $where;";
            $result = $connect->query($sql);
            
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions'>". "<strong>Member Name: </strong>".$row['Member_First_Name']. " ".$row['Member_Last_Name']. "<p>";
                    echo "<div class='transitions divider'></div>";
                }
            }
            //SQL QUERY 2: Selects a members membership type from the Membership table which can only be either, Gold, Silver or Bronze and the condition is based on the member ID they entered into Form1. Form1 is on the account.php page.
            $sql = "SELECT Membership_Type FROM MEMBERSHIP WHERE $where;";
            $result = $connect->query($sql);
            
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions'>". "<strong>Membership Type: </strong>".$row['Membership_Type']. "<p>";
                    echo "<div class='transitions divider'></div>";
                }
            }
            //SQL QUERY 3: Selects the first and last name of a members emergency contact from the Emergency Contact table and the condition is based on the member ID they entered into Form1. Form1 is on the account.php page.
            $sql = "SELECT Emergency_Contact_First_Name, Emergency_Contact_Last_Name FROM EMERGENCY_CONTACT WHERE $where;";
            $result = $connect->query($sql);
            
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions'>". "<strong>Emergency Contact Details: </strong>".$row['Emergency_Contact_First_Name']. " ".$row['Emergency_Contact_Last_Name']."<p>";
                    echo "<div class='transitions  divider'></div>";
                }
            }
            else {
                echo "<p class='transitions'><strong>No results</strong></p>";
            }
            //SQL QUERY 4: Counts the total number of classes that a member has booked.
            $sql = "SELECT COUNT(Gym_Class_Id) FROM BOOK_GYM_CLASS WHERE $where GROUP BY Member_Id;";
            $result = $connect->query($sql);
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions'>". "<strong>Booked classes this week: </strong>" . $row['COUNT(Gym_Class_Id)']. "<p>";
                }
                echo "<div class='transitions divider'></div>";
            }
            //SQL QUERY 5: Selects the names of gym classes a member has booked and also displays the number of gym classes booked at gym class name level. This design means the number of gym classes booked by name will be correct if another gym class that has the same name but a different time is added to the timetable in the future.
            $sql = "SELECT Gym_Class_Name, COUNT(Gym_Class_Name) FROM GYM_CLASS INNER JOIN BOOK_GYM_CLASS ON GYM_CLASS.Gym_Class_Id = BOOK_GYM_CLASS.Gym_Class_Id WHERE $where GROUP BY Gym_Class_Name;";
            $result = $connect->query($sql);
            if ($result->num_rows > 0) {
                echo "<p class='transitions'><strong>Class Breakdown:</strong></p>";
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions' id='indent'>". $row['Gym_Class_Name']. "  x".$row['COUNT(Gym_Class_Name)']. "<p>";
                }
                echo "<div class='transitions divider'></div>";
            } else {
                echo "<p class='transitions'><strong>No bookings</strong></p>";
            }
            //SQL QUERY 6: Selects the gym class name, day and time of booked classes that the member has booked.
            $sql = "SELECT Gym_Class_Name, Gym_Class_Day, Gym_Class_Time FROM GYM_CLASS INNER JOIN BOOK_GYM_CLASS ON GYM_CLASS.Gym_Class_Id = BOOK_GYM_CLASS.Gym_Class_Id WHERE $where;";
            $result = $connect->query($sql);
            if ($result->num_rows > 0) {
                echo "<p class='transitions'><strong>Class Details: </strong></p>";
                while($row = $result->fetch_assoc()) {
                    echo "<p class='transitions' id='indent'>".$row['Gym_Class_Name'] ." - " .$row['Gym_Class_Day'] .", " .$row['Gym_Class_Time']. "<p>";
                }
            }
            mysqli_free_result($result);
        }
?>
<html>
<!-- HTML header -->
    <head>
        <link href="style.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </head>
    <body>
<!-- Page title -->
        <div class="row">
            <div id = "banner" class="col-md-12">
                <h1 class="">Sports Park Member Account Page</h1>
            </div>
        </div>

<!-- Form1 -->
        <div class="row">
            <div class="col-md-6">
                    <p id="search-text" class="lead">Search for account details by entering your Member ID below:</p>
                        <form class="form-inline" method="POST">
                            <div class="form-group">
                                <input class="form-control" type="text" name="search" placeholder="Search Database" value="<?php if(isset($_POST['search'])) {echo htmlentities($_POST['search']);}?>"/>
                            </div>
                                <br>
                                <input class="btn btn-primary" type="submit" name="submit1" value="Search"/>
                        </form>
<!-- Call PHP database function -->
    <?php 
        database();
    ?>   
        </div>
<!-- Pool image -->
            <div class="col-md-6">
                <img id="pool" class="" src="pool.jpg">
                <br></br>
<!-- Manage bookings button -->
                    <form class="form-group form" method="POST" action="manage_bookings.php">
                        <input type="hidden" name="variable" value="<?= "$query" ?>">
                        <input class="btn btn-primary add-booking-button" type="submit" name="submit" value="Add Booking">
                    </form>
            </div>
        </div>
<!-- Javascript for fade-in functionality -->
    <script>
        // Event listener fuctionality: When the page loads it will trigger the function FadeIn.
        window.addEventListener("load", fadeIn);
        //Function Fade in: No parameters needed, no return value. Purpose of function is to add opacity and transition styling to the 'transitions' classes by lopping through them.
        function fadeIn() {
            // Store all the elements which have 'transitions' as their class into an array list called 'elements'.
            var elements = document.querySelectorAll('.transitions');
                //For loop to loop through all the 'transitions' classes.'i' represents the position of an element in the array.
                for (var i = 0; i < elements.length; i++) {
                    elements[i].style.transition = "opacity 1s ease-in";
                    elements[i].style.opacity = "1";
                }
        }
    </script>
    <script></script>
    </body>
</html>