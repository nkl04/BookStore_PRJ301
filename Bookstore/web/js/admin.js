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
            const barChartOptions = {
                series: [
                    {
                        data: [10, 8, 6, 4, 2],
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

            const barChart = new ApexCharts(
                    document.querySelector("#bar-chart"),
                    barChartOptions
                    );
            barChart.render();

// AREA CHART
            const areaChartOptions = {
                series: [
                    {
                        name: "Purchase Orders",
                        data: [31, 40, 28, 51, 42, 109, 100],
                    },
                ],
                chart: {
                    type: "area",
                    background: "transparent",
                    height: 350,
                    stacked: false,
                    toolbar: {
                        show: false,
                    },
                },
                colors: ["#00ab57", "#d50000"],
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
                dataLabels: {
                    enabled: false,
                },
                fill: {
                    gradient: {
                        opacityFrom: 0.4,
                        opacityTo: 0.1,
                        shadeIntensity: 1,
                        stops: [0, 100],
                        type: "vertical",
                    },
                    type: "gradient",
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
                markers: {
                    size: 6,
                    strokeColors: "#1b2635",
                    strokeWidth: 3,
                },
                stroke: {
                    curve: "smooth",
                },
                xaxis: {
                    axisBorder: {
                        color: "#55596e",
                        show: true,
                    },
                    axisTicks: {
                        color: "#55596e",
                        show: true,
                    },
                    labels: {
                        offsetY: 5,
                        style: {
                            colors: "#000000",
                        },
                    },
                },
                yaxis: [
                    {
                        title: {
                            text: "Purchase Orders",
                            style: {
                                color: "#000000",
                            },
                        },
                        labels: {
                            style: {
                                colors: ["#000000"],
                            },
                        },
                    },
                    {
                        opposite: true,
                        title: {
                            text: "Sales Orders",
                            style: {
                                color: "#000000",
                            },
                        },
                        labels: {
                            style: {
                                colors: ["#000000"],
                            },
                        },
                    },
                ],
                tooltip: {
                    shared: true,
                    intersect: false,
                    theme: "dark",
                },
            };

            const areaChart = new ApexCharts(
                    document.querySelector("#area-chart"),
                    areaChartOptions
                    );
            areaChart.render();

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
            fileInput.addEventListener('change', function() {
            const file = this.files[0]; // Get the selected file

                    // Check if a file is selected
                    if (file) {
            const reader = new FileReader(); // Create a FileReader object

                    // Define onload event handler
                    reader.onload = function(event) {
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
    
    if(title.trim().length === 0)
    {
        alert('Wrong input title.');
        return;
    }
    
    if(author.trim().length === 0)
    {
        alert('Wrong input author.');
        return;
    }
    
    if(publisher.trim().length === 0)
    {
        alert('Wrong input publisher.');
        return;
    }
    
    if(description.trim().length === 0)
    {
        alert('Wrong input description.');
        return;
    }
    
    if(language.trim().length === 0)
    {
        alert('Wrong input language.');
        return;
    }
    
    if(publicationDate.trim().length === 0)
    {
        alert('Wrong input date.');
        return;
    }
    
    
    if(genre.trim().length === 0)
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
    
    
    if(title.trim().length === 0)
    {
        alert('Wrong input title.');
        return;
    }
    
    // If a file is selected and an image preview is present, allow form submission
    document.querySelector('.genre-popup form').submit();
}