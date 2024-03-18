<%-- 
    Document   : admin
    Created on : 15 thg 2, 2024, 20:35:43
    Author     : Win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <title>Admin Dashboard</title>

        <!--         Montserrat Font -->
        <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet"
            />

        <!--         Material Icons -->
        <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined"
            rel="stylesheet"
            />

        <!-- Custom CSS -->

    </head>
    <body>
        <style><jsp:include page="styles/admin.css"></jsp:include></style>
            <div class="grid-container">

                <div id="sidebar">
                    <div class="sidebar-title">
                        <div class="sidebar-brand">
                            <img src="images/logo.png" alt="logo" width="40px" height="40px" />
                            <a href="home" style="color: #9e9ea4; text-decoration: none;"><h1>BookShop</h1></a>
                        </div>

                    </div>

                    <ul class="sidebar-list">
                        <li class="sidebar-list-item active">
                            <span class="material-icons-outlined">dashboard</span> Dashboard
                        </li>
                        <li class="sidebar-list-item">
                            <span class="material-icons-outlined">inventory_2</span> Products
                        </li>
                        <li class="sidebar-list-item">
                            <span class="material-icons-outlined">category</span> Categories
                        </li>
                        <li class="sidebar-list-item">
                            <span class="material-icons-outlined">description</span> Orders
                        </li>
                        <li class="sidebar-list-item">
                            <span class="material-icons-outlined">groups</span> Customers
                        </li>
                    </ul>
                </div>
                <!-- End Sidebar -->

                <!-- Main -->
                <main class="main-container">
                    <div class="content active">
                        <div class="main-title">
                            <h2>DASHBOARD</h2>
                        </div>

                        <div class="main-cards">
                            <div class="card">
                                <div class="card-inner">
                                    <h3>PRODUCTS</h3>
                                    <span class="material-icons-outlined">inventory_2</span>
                                </div>
                                <h1>${listB.size()}</h1>
                        </div>

                        <div class="card">
                            <div class="card-inner">
                                <h3>CATEGORIES</h3>
                                <span class="material-icons-outlined">category</span>
                            </div>
                            <h1>${listG.size()}</h1>
                        </div>

                        <div class="card">
                            <div class="card-inner">
                                <h3>ORDERS</h3>
                                <span class="material-icons-outlined">description</span>
                            </div>
                            <h1>${listO.size()}</h1>
                        </div>
                        <div class="card">
                            <div class="card-inner">
                                <h3>CUSTOMERS</h3>
                                <span class="material-icons-outlined">groups</span>
                            </div>
                            <h1>${listU.size()}</h1>
                        </div>
                    </div>

                    <div class="charts" style="display: flex; justify-content: center;">
                        <div class="charts-card" style="width: 800px;">
                            <h2 class="chart-title">Quantity of Items Sold by Category</h2>
                            <div id="bar-chart"></div>
                        </div>
                    </div>
                </div>
                <div class="limiter content">
                    <div class="add-btn book">Add Book</div>
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head">
                                            <th class="column1">ID</th>
                                            <th class="column2">Title</th>
                                            <th class="column2">Author</th>
                                            <th class="column2">Pulisher</th>
                                            <th class="column2">Description</th>
                                            <th class="column2">Genre</th>
                                            <th class="column3">Language</th>
                                            <th class="column4">PublicationDate</th>
                                            <th class="column5">bookImage</th>
                                            <th class="column5">Quantity In Stock</th>
                                            <th class="column6">Price</th>
                                            <th class="column6">Pages</th>
                                            <th colspan="2">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach var="i" items="${requestScope.listB}">
                                            <tr>
                                                <td class="column1">${i.id}</td>
                                                <td class="column2">${i.title}</td>
                                                <td class="column2">${i.author}</td>
                                                <td class="column2">${i.publisher}</td>
                                                <td class="column2">
                                                    <div>
                                                        ${i.description}
                                                    </div>
                                                </td>
                                                <td class="column2">${i.genre}</td>
                                                <td class="column3">${i.language}</td>
                                                <td class="column4">${i.publicationDate}</td>
                                                <td class="column5"><img src="images/${i.bookImage}" alt="alt" width="80" height="120"/></td>
                                                <td class="column5">${i.qtyInStock}</td>
                                                <td class="column6">$${i.price}</td>
                                                <td class="column6">${i.pages}</td>
                                                <td>
                                                    <div class="edit-btn book" v>Edit</div>
                                                </td>
                                                <td>
                                                    <div class="delete-btn book" v>Delete</div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="limiter content">
                    <div class="add-btn genre">Add Genre</div>
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head">
                                            <th class="column1-genre">ID</th>
                                            <th class="column2-genre">Title</th>
                                            <th colspan="2">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach var="i" items="${listG}">
                                            <tr><td class="column1-genre">${i.id}</td>
                                                <td class="column2-genre">
                                                    <div>${i.title}</div>
                                                </td>
                                                <td>
                                                    <div class="edit-btn genre" v>Edit</div>
                                                </td>
                                                <!--                                                <td>
                                                                                                    <div class="delete-btn genre" v>Delete</div>
                                                                                                </td>-->
                                            </tr>
                                        </c:forEach>


                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="limiter content">
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head">
                                            <th class="column1">ID</th>
                                            <th class="column2">User ID</th>
                                            <th class="column3">Order Date</th>                                           
                                            <th class="column3">Status</th>
                                            <th class="column3">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="i" items="${listO}">
                                            <tr>

                                                <td class="column1">${i.ID}</td>
                                                <td class="column2">${i.user.id}</td>
                                                <td class="column3">${i.orderDate}</td>
                                                <td class="column4">${i.orderStatus}</td>

                                                <td>
                                                    <a href="orders?action=orderDetail&id=${i.ID}" style="color: #9e9ea4; text-decoration: none;"><div class="show-btn">Show</div></a>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="limiter content">
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head">
                                            <th class="column1">ID</th>
                                            <th class="column2">First Name</th>
                                            <th class="column2">Last Name</th>                                           
                                            <th class="column2">Email</th>                                        
                                            <th class="column2">Address</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="i" items="${listU}">
                                            <tr>

                                                <td class="column1">${i.id}</td>
                                                <td class="column2">${i.firstName}</td>
                                                <td class="column3">${i.lastName}</td>
                                                <td class="column4">${i.email}</td>
                                                <td class="column4">${i.address}</td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- form book -->
                <div class="book-popup">
                    <div class="form">
                        <div class="close-btn">&times;</div>
                        <h1>Book Detail</h1>
                        <form action="" method="post" class="login-form" enctype="multipart/form-data">
                            <input type="text" placeholder="Title" name="title" />
                            <input type="text" placeholder="Author" name="author" />
                            <select name="genre" id="">
                                <option value="">Genre</option>
                                <c:forEach var="i" items="${listG}">
                                    <option value="${i.title}">${i.title}</option>                                    
                                </c:forEach>

                            </select>
                            <textarea
                                type="text"
                                name="description"
                                id=""
                                class="text-description"
                                placeholder="Description"
                                ></textarea
                            ><input type="text" placeholder="Publisher" name="publisher" />
                            <input type="text" placeholder="Language" name="language" />
                            <input type="date" placeholder="Publication Date" name="publicationDate" />
                            <img id="previewImage" src="" alt="Image Preview" style="display: none;" width="60" height="90">
                            <input type="file" placeholder="Book Image" name="bookImage" id="fileInput"/>
                            <input type="text" placeholder="Quantity in Stock" name="qtyInStock" />
                            <input type="text" placeholder="Price" name="price" />
                            <input type="text" placeholder="Pages" name="pages" />

                            <button type="button" onclick="validateBookForm()">Add Book</button>
                        </form>
                    </div>
                </div>

                <div class="genre-popup">
                    <div class="form">
                        <div class="close-btn">&times;</div>
                        <h1>Book Detail</h1>
                        <form action="" method="post" class="login-form">
                            <input type="text" placeholder="Title" name="title" />
                            <button type="button" onclick="validateGenreForm()">Add Genre</button>
                        </form>
                    </div>
                </div>
            </main>
            <!-- End Main -->
        </div>

        <!-- Scripts -->
        <!-- ApexCharts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.5/apexcharts.min.js"></script>
        <!-- Custom JS -->
        <script>
                                /* 
                                 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
                                 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
                                 */


// SIDEBAR TOGGLE

                                let sidebarOpen = false;
                                const sidebar = document.getElementById("sidebar");

                                function openSidebar() {
                                    if (!sidebarOpen) {
                                        sidebar.classList.add("sidebar-responsive");
                                        sidebarOpen = true;
                                    }
                                }

                                function closeSidebar() {
                                    if (sidebarOpen) {
                                        sidebar.classList.remove("sidebar-responsive");
                                        sidebarOpen = false;
                                    }
                                }

// ---------- CHARTS ----------

// BAR CHART


//                                const barChart = new ApexCharts(
//                                        document.querySelector("#bar-chart"),
//                                        barChartOptions
//                                        );
//                                barChart.render();

// Function to fetch data from servlet endpoint and update chart
                                function fetchDataFromServlet(data) {
                                    // Extract data and categories from the received data
                                    const newData = data.map(item => item.value); // Assuming data is an array of objects with a 'value' property
                                    const newCategories = data.map(item => item.category); // Assuming data is an array of objects with a 'category' property

                                    // Update chart with the new data and categories
                                    barChart.updateOptions({
                                        series: [{data: newData}],
                                        xaxis: {
                                            categories: newCategories,
                                        }
                                    });
                                }

// Function to render the chart
                                let barChart;
                                function renderChart() {
                                    const barChartOptions = {
                                        series: [
                                            {
                                                data: [15, 8, 6, 4, 2],
                                                name: "Products",
                                            },
                                        ],
                                        chart: {
                                            type: "bar",
                                            background: "transparent",
                                            height: 350,
                                            toolbar: {
                                                show: false,
                                            },
                                        },
                                        colors: ["#2962ff", "#d50000", "#2e7d32", "#ff6d00", "#583cb3"],
                                        plotOptions: {
                                            bar: {
                                                distributed: true,
                                                borderRadius: 4,
                                                horizontal: false,
                                                columnWidth: "40%",
                                            },
                                        },
                                        dataLabels: {
                                            enabled: false,
                                        },
                                        fill: {
                                            opacity: 1,
                                        },
                                        grid: {
                                            borderColor: "#55596e",
                                            yaxis: {
                                                lines: {
                                                    show: true,
                                                },
                                            },
                                            xaxis: {
                                                lines: {
                                                    show: true,
                                                },
                                            },
                                        },
                                        legend: {
                                            labels: {
                                                colors: "#000000",
                                            },
                                            show: true,
                                            position: "top",
                                        },
                                        stroke: {
                                            colors: ["transparent"],
                                            show: true,
                                            width: 2,
                                        },
                                        tooltip: {
                                            shared: true,
                                            intersect: false,
                                            theme: "dark",
                                        },
                                        xaxis: {
                                            categories: ["Laptop", "Phone", "Monitor", "Headphones", "Camera"],
                                            title: {
                                                style: {
                                                    color: "#000000",
                                                },
                                            },
                                            axisBorder: {
                                                show: true,
                                                color: "#55596e",
                                            },
                                            axisTicks: {
                                                show: true,
                                                color: "#55596e",
                                            },
                                            labels: {
                                                style: {
                                                    colors: "#000000",
                                                },
                                            },
                                        },
                                        yaxis: {
                                            title: {
                                                text: "Count",
                                                style: {
                                                    color: "#000000",
                                                },
                                            },
                                            axisBorder: {
                                                color: "#55596e",
                                                show: true,
                                            },
                                            axisTicks: {
                                                color: "#55596e",
                                                show: true,
                                            },
                                            labels: {
                                                style: {
                                                    colors: "#000000",
                                                },
                                            },
                                        },
                                    };

                                    // Create the chart
                                    barChart = new ApexCharts(document.querySelector("#bar-chart"), barChartOptions);

                                    // Render the chart
                                    barChart.render();

                                    // Fetch data from servlet and update chart
                                    fetch('chartData') // Replace 'servletEndpointURL' with the actual servlet endpoint URL
                                            .then(response => response.json())
                                            .then(data => {
                                                // Update chart with fetched data
                                                fetchDataFromServlet(data);
                                            })
                                            .catch(error => {
                                                console.error('Error fetching data:', error);
                                            });
                                }

// Call the renderChart function to render the chart initially
                                renderChart();



                                const tabs = document.querySelectorAll(".sidebar-list-item");
                                const all_content = document.querySelectorAll(".content");

                                tabs.forEach((tab, index) => {
                                    tab.addEventListener("click", (e) => {
                                        tabs.forEach((tab) => {
                                            tab.classList.remove("active");
                                        });
                                        tab.classList.add("active");

                                        all_content.forEach((content) => {
                                            content.classList.remove("active");
                                        });
                                        all_content[index].classList.add("active");
                                    });
                                });

                                document.querySelectorAll(".edit-btn.book").forEach(button => {
                                    button.addEventListener("click", function () {
                                        // Find the parent row of the clicked button
                                        const row = this.closest('tr');
                                        console.log(row);
                                        // Extract data from the row
                                        const cells = row.querySelectorAll('td');
                                        const id = cells[0].textContent.trim();
                                        const title = cells[1].textContent.trim();
                                        const author = cells[2].textContent.trim();
                                        const publisher = cells[3].textContent.trim();
                                        const description = cells[4].textContent.trim();
                                        const genre = cells[5].textContent.trim();
                                        const language = cells[6].textContent.trim();
                                        const publicationDate = cells[7].textContent.trim();
                                        const bookImage = cells[8].querySelector("img").src;
                                        const qtyInStock = cells[9].textContent.trim();
                                        const price = cells[10].textContent.trim().substring(1);
                                        const pages = cells[11].textContent.trim();
                                        // Extract other data similarly for other columns
                                        console.log(bookImage);
                                        // Populate the form fields with the extracted data
//        document.querySelector('.book-popup input[name="id"]').value = id;
                                        document.querySelector('.book-popup input[name="title"]').value = title;
                                        document.querySelector('.book-popup input[name="author"]').value = author;
                                        document.querySelector('.book-popup input[name="publisher"]').value = publisher;
                                        document.querySelector('.book-popup textarea[name="description"]').value = description;
                                        document.querySelector('.book-popup input[name="language"]').value = language;
                                        document.querySelector('.book-popup input[name="publicationDate"]').value = publicationDate;
//        document.querySelector('.book-popup input[name="bookImage"]').value = bookImage;
                                        document.getElementById('previewImage').src = bookImage;
                                        document.getElementById('previewImage').style.display = "block";
                                        //document.querySelector('.book-popup input[name="bookImage"]').value = bookImage;
                                        document.querySelector('.book-popup input[name="qtyInStock"]').value = qtyInStock;
                                        document.querySelector('.book-popup input[name="price"]').value = price;
                                        document.querySelector('.book-popup input[name="pages"]').value = pages;
                                        document.querySelector('.book-popup select[name="genre"]').value = genre;
                                        // Populate other form fields similarly for other data

                                        document.querySelector(".book-popup form").action = "updateBook?id=" + id;
                                        document.querySelector(".book-popup button").textContent = "Update Book";
                                        document.querySelector(".book-popup").classList.add("active");
                                    });
                                });
                                document.querySelectorAll(".delete-btn.book").forEach(button => {
                                    button.addEventListener("click", function () {
                                        const row = this.closest('tr');
                                        const cells = row.querySelectorAll('td');
                                        const id = cells[0].textContent.trim();
                                        window.location.href = "deleteBook?id=" + id;
                                    });
                                });
                                document
                                        .querySelector(".book-popup .form .close-btn")
                                        .addEventListener("click", function () {
                                            document.getElementById('previewImage').style.display = "none";
                                            document.querySelector(".book-popup form").reset();
                                            document.querySelector(".book-popup").classList.remove("active");
                                        });
                                document.querySelector(".add-btn.book").addEventListener("click", function () {
                                    document.querySelector(".book-popup form").action = "addbook";
                                    document.querySelector(".book-popup button").textContent = "Add Book";
                                    document.querySelector(".book-popup").classList.add("active");
                                });
                                document
                                        .querySelector(".edit-btn.genre")
                                        .addEventListener("click", function () {
                                            document.querySelector(".genre-popup").classList.add("active");
                                        });
                                document.querySelectorAll(".edit-btn.genre").forEach(button => {
                                    button.addEventListener("click", function () {
                                        // Find the parent row of the clicked button
                                        const row = this.closest('tr');
                                        console.log(row);
                                        // Extract data from the row
                                        const cells = row.querySelectorAll('td');
                                        const id = cells[0].textContent.trim();
                                        const title = cells[1].textContent.trim();

                                        // Populate the form fields with the extracted data
//        document.querySelector('.book-popup input[name="id"]').value = id;
                                        document.querySelector('.genre-popup input[name="title"]').value = title;

                                        // Populate other form fields similarly for other data

                                        document.querySelector(".genre-popup form").action = "updateGenre?id=" + id;
                                        document.querySelector(".genre-popup button").textContent = "Update Genre";
                                        document.querySelector(".genre-popup").classList.add("active");
                                    });
                                });
                                document
                                        .querySelector(".genre-popup .form .close-btn")
                                        .addEventListener("click", function () {
                                            document.querySelector(".genre-popup form").reset();
                                            document.querySelector(".genre-popup").classList.remove("active");
                                        });
                                document.querySelector(".add-btn.genre").addEventListener("click", function () {
                                    document.querySelector(".genre-popup form").action = "addGenre";
                                    document.querySelector(".genre-popup button").textContent = "Add Genre";
                                    document.querySelector(".genre-popup").classList.add("active");
                                });



                                const fileInput = document.getElementById('fileInput');
                                const previewImage = document.getElementById('previewImage');
                                // Add change event listener to the file input
                                fileInput.addEventListener('change', function () {
                                    const file = this.files[0]; // Get the selected file

                                    // Check if a file is selected
                                    if (file) {
                                        const reader = new FileReader(); // Create a FileReader object

                                        // Define onload event handler
                                        reader.onload = function (event) {
                                            // Set the src attribute of the image element to the data URL of the selected image
                                            previewImage.src = event.target.result;
                                            previewImage.style.display = 'block'; // Show the image element
                                        };
                                        // Read the selected file as a data URL
                                        reader.readAsDataURL(file);
                                    } else {
                                        // If no file is selected, hide the image element
                                        previewImage.style.display = 'none';
                                    }
                                });


                                function validateBookForm() {
                                    const title = document.querySelector('.book-popup input[name="title"]').value;
                                    const author = document.querySelector('.book-popup input[name="author"]').value;
                                    const publisher = document.querySelector('.book-popup input[name="publisher"]').value;
                                    const description = document.querySelector('.book-popup textarea[name="description"]').value;
                                    const language = document.querySelector('.book-popup input[name="language"]').value;
                                    const publicationDate = document.querySelector('.book-popup input[name="publicationDate"]').value;
                                    const qtyInStock = document.querySelector('.book-popup input[name="qtyInStock"]').value;
                                    const price = document.querySelector('.book-popup input[name="price"]').value;
                                    const pages = document.querySelector('.book-popup input[name="pages"]').value;
                                    const genre = document.querySelector('.book-popup select[name="genre"]').value;
                                    // Get the file input and image preview elements
                                    const fileInput = document.querySelector('.book-popup input[name="bookImage"]');
                                    const imagePreview = document.getElementById('previewImage');

                                    if (title.trim().length === 0)
                                    {
                                        alert('Wrong input title.');
                                        return;
                                    }

                                    if (author.trim().length === 0)
                                    {
                                        alert('Wrong input author.');
                                        return;
                                    }

                                    if (publisher.trim().length === 0)
                                    {
                                        alert('Wrong input publisher.');
                                        return;
                                    }

                                    if (description.trim().length === 0)
                                    {
                                        alert('Wrong input description.');
                                        return;
                                    }

                                    if (language.trim().length === 0)
                                    {
                                        alert('Wrong input language.');
                                        return;
                                    }

                                    if (publicationDate.trim().length === 0)
                                    {
                                        alert('Wrong input date.');
                                        return;
                                    }


                                    if (genre.trim().length === 0)
                                    {
                                        alert('Wrong input genre.');
                                        return;
                                    }

                                    // Try parsing the input value as an integer
                                    let intValue = parseInt(qtyInStock);
                                    if (isNaN(intValue) || !(intValue.toString() === qtyInStock) || intValue < 0) {
                                        alert('Wrong input quantity.');
                                        return;
                                    }

                                    // Try parsing the input value as a float
                                    let floatValue = parseFloat(price);
                                    if (isNaN(floatValue) || !(floatValue.toString() === price) || price < 0) {

                                        alert('Wrong input price.');
                                        return;
                                    }

                                    intValue = parseInt(pages);
                                    if (isNaN(intValue) || !(intValue.toString() === pages) || intValue < 0) {
                                        alert('Wrong input pages.');
                                        return;
                                    }

                                    // Check if an image preview is present (i.e., an image has been selected)
                                    if ((imagePreview.style.display === 'none') && fileInput.files.length === 0) {
                                        // Image preview is null or empty, display an error message or take appropriate action
                                        alert('Please select an image.');
                                        console.log("none")
                                        return; // Prevent form submission
                                    }

                                    // If a file is selected and an image preview is present, allow form submission
                                    document.querySelector('.book-popup form').submit();
                                }

                                function validateGenreForm() {
                                    const title = document.querySelector('.genre-popup input[name="title"]').value;


                                    if (title.trim().length === 0)
                                    {
                                        alert('Wrong input title.');
                                        return;
                                    }

                                    // If a file is selected and an image preview is present, allow form submission
                                    document.querySelector('.genre-popup form').submit();
                                }
        </script>

    </body>
</html>
