<html>
<!-- HTML header -->
    <head>
        <link href="style.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </head>
    <body>
<!-- Banner -->
        <div class="banner">
            <img id="banner-image" src="banner.jpg">
            <h1 id="header">Booking Page</h1>
        </div>
<!-- Header -->
        <div class="col-md-4 section">
            <p class="header lead">Book a Class: </p>
        </div>
<!-- Form3 -->
            <br>
        <div class="col-md-4 section">
            <form class="form-group" method="POST">
            <p><select id="classes" name="classes">
                <option value='00011'<?php keep_option('00011'); ?>>Yoga</option>
                <option value='00022'<?php keep_option('00022'); ?>>Strength and Tone</option>
                <option value='00033'<?php keep_option('00033'); ?>>Indoor Cycling</option>
                <option value='00044'<?php keep_option('00044'); ?>>Dance Inspired Class</option>
                <option value='00055'<?php keep_option('00055'); ?>>Aqua</option>
            </select>
            <br>
            <input class="submit-button btn btn-primary buttons" type="submit" value="Search"/>
            </p>
            </form>
        </div>
<!-- Function to get database data for form3 -->
    <?php
        select();
    ?>

<!-- Button to go back to previous page -->
        <p><a href="account.php"><br>Back to Account page</a></p>
    </body>
</html>

<?php
//Connect to database function
    function connect() {

            $server = "localhost";
            $database = "Account";
            $username = "root";
            $password = "root";

            $connect = new mysqli($server, $username, $password, $database);

            if ($connect->connect_error) {
                die("Failed Connection: " . $connect->connect_error);
            }
            return $connect;
    }

//Select a class to retrieve database data of class times and days
    function select() {
        if (isset($_POST['classes'])) {
            $connect = connect();
            $option = isset($_POST['classes']) ? $_POST['classes'] : false;
            $value = $_POST['classes'];
            setcookie('classes', $value, time()+3600);
            $where = "Gym_Class_Name_Id = $value";
            //SQL QUERY 7: Selects the gym class day, time and id from the Gym Class table where the condition equals the gym class name ID.
            $sql = "SELECT Gym_Class_Day, Gym_Class_Time, Gym_Class_Id FROM GYM_CLASS WHERE $where;";   
            $result = $connect->query($sql);

            if($option) {
                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        $id = $row['Gym_Class_Id'];
                        setcookie('class_id', $id, time()+3600);
                        $form = "<div class='col-md-4'><form method='POST'><div class='check section'><input class='box' value='select' type='checkbox' name='select'" . $row["Gym_Class_Day"] . ", " . $row['Gym_Class_Time']."' ><label id='details-text'for='" . $row["Gym_Class_Day"] . ", " . $row['Gym_Class_Time']."'>" . $row["Gym_Class_Day"] . ", " . $row['Gym_Class_Time']."</label><input class='buttons btn btn-primary add' type='submit' value='Add'></div></form></div>";
                        echo $form;
                        echo "<div class='divider'></div>";
                    }
                }
                //SQL QUERY 8: Select an instructors first name from the Instructor table where the condition equals the gym class name ID.
                $sql = "SELECT Instructor_First_Name FROM INSTRUCTOR WHERE Gym_Class_Id = (SELECT Gym_Class_Id FROM GYM_CLASS WHERE $where);";
                $result = $connect->query($sql);
                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<p><strong>Instructor's Name: </strong>". $row['Instructor_First_Name']."</p>";
                        echo "<div class='divider'></div>";
                    }
                }
            }
            mysqli_free_result($result);
            $connect->close();
        }
    }
        
        if (isset($_POST['select'])) {
            $connect = connect();
            $member_id = $_COOKIE['search'];
            $class_name_id = $_COOKIE['classes'];
            $class_id = $_COOKIE['class_id'];
            $member_id_sql = "Member_Id = '$member_id'";
            $class_id_sql = "Gym_Class_Id = '$class_id'";
            
            // SQL QUERY 10: Selects the member ID and class ID from the book gym class table and if the result is 1 that class has already been booked for that user and the user is not able to book it again that week.
            $sql = "SELECT Member_Id, Gym_Class_Id FROM BOOK_GYM_CLASS WHERE $member_id_sql AND $class_id_sql";
            $result = $connect->query($sql);
                if ($result->num_rows == 0) {
                    //SQL QUERY 9: Inserts into the Book Gym Class table the class ID and member ID using a cookie which saved the member ID and class ID so that the database now contains the new booking for the member.
                    $sql = "INSERT INTO BOOK_GYM_CLASS (Member_Id, Gym_Class_Id) VALUES ('$member_id', '$class_id');";
                    $result = $connect->query($sql);
                    // or die( mysqli_error($connect));
                    echo "<p><br>"."Class was successfully added to account</p>";
                } else {
                    echo "<p><br>"."You have already booked this class</p>";
                }
            $connect->close();           
        }
    
//A function to keep the option value in form
    function keep_option($value) {
		if (isset($_POST['classes']) && $_POST['classes'] == $value) {
			echo 'selected';
		}
	}
?>