  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="index.html">HRN</a></h1>
      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="index.html#hero"><%= (new Translate()).translate("Home", request.getParameter("language"))%></a></li>
          <li><a class="nav-link scrollto" href="index.html#services"><%= (new Translate()).translate("Services", request.getParameter("language"))%></a></li>
          <li><a class="nav-link scrollto" href="index.html#portfolio"><%= (new Translate()).translate("Portfolio", request.getParameter("language"))%></a></li>
          <li><a class="nav-link scrollto" href="index.html#team"><%= (new Translate()).translate("Team", request.getParameter("language"))%></a></li>
          <li><a class="nav-link scrollto" href="index.html#contact"><%= (new Translate()).translate("Contact", request.getParameter("language"))%></a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->
    </div>
  </header><!-- End Header -->
