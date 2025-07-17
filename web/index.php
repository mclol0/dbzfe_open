<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dragon Ball Z: Fighter's Edition</title>
    
    <!-- Favicon -->
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' fill='%23ff6b1a'/><circle cx='16' cy='16' r='10' fill='%23ffd700'/><text x='16' y='20' text-anchor='middle' fill='%23000' font-family='Arial' font-size='12'>🐉</text></svg>">
    <link rel="apple-touch-icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' fill='%23ff6b1a'/><circle cx='16' cy='16' r='10' fill='%23ffd700'/><text x='16' y='20' text-anchor='middle' fill='%23000' font-family='Arial' font-size='12'>🐉</text></svg>">
    
    <link rel="stylesheet" type="text/css" href="modern-style.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
    <!-- Background particles -->
    <div id="particles-bg"></div>
    
    <!-- Scroll progress bar -->
    <div class="scroll-progress"></div>
    
    <div class="main-container">
        <!-- Header Section -->
        <header class="header">
            <div class="header-content">
                <div class="logo-container">
                    <img src="img/logo.png" alt="Dragon Ball Z: Fighter's Edition" class="logo">
                    <div class="logo-glow"></div>
                </div>
                <div class="header-effects">
                    <div class="energy-orb orb-1"></div>
                    <div class="energy-orb orb-2"></div>
                    <div class="energy-orb orb-3"></div>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="navbar">
            <div class="nav-container">
                <button class="mobile-menu-toggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
                <div class="nav-menu">
                    <?php include 'inc/nav.inc.php'; ?>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-container">
                <div class="content-box">
                    <div class="content-inner">
                        <?php
                        if(isset($_GET['page']))
                        {
                            $cur_page = 'pages/'.$_GET['page'].'.php';
                            if(file_exists($cur_page))
                            {
                                include $cur_page;
                            }
                            else
                            {
                                include 'pages/index.php';
                            }
                        }
                        else
                        {
                            include 'pages/index.php';
                        }
                        ?>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-text">
                    <p>&copy; 2013-2025 ThunderZ | Dragon Ball Z: Fighter's Edition</p>
                </div>
                <div class="footer-links">
                    <a href="https://discord.gg/QynAjm2axA" target="_blank" class="social-link" title="Join our Discord"><i class="fab fa-discord"></i></a>
                    <a href="#" class="social-link" title="Follow on Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link" title="Subscribe on YouTube"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </footer>
    </div>

    <!-- JavaScript -->
    <script src="modern-script.js"></script>
    
    <script>
    // Legacy popup window function for compatibility
    var win=null;
    function NewWindow(mypage,myname,w,h,scroll,pos){
        if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
        if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
        else if((pos!="center" && pos!="random") || pos==null){LeftPosition=0;TopPosition=20}
        settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=yes,menubar=no,toolbar=no,resizable=no';
        win=window.open(mypage,myname,settings);
    }
    </script>
</body>
</html>
