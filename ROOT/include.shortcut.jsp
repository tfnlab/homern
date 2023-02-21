<script>
  function newCustomer() {
    window.open("customer.new.jsp", "_self");
  }
  function newOrder() {
    window.open("order.new.jsp", "_self");
  }
  function newProducts() {
    window.open("product.list.jsp", "_self");
  }
  function getCalendarView() {
    window.open("event.list.calendar.jsp", "_self");
  }
  function getUserMenu() {
    window.open("user.menu.jsp", "_self");
  }
  function getDashboard() {
    window.open("dashboard.jsp", "_self");
  }
  function getEdituser() {
    window.open("user.edit.jsp", "_self");
  }
  document.addEventListener("keydown", function(event) {
    // Check if the "Ctrl" and "C" keys are pressed
    if (event.ctrlKey && event.keyCode == 67) {
      event.preventDefault();
      newCustomer();
    }
    if (event.ctrlKey && event.keyCode == 79) {
      event.preventDefault();
      newOrder();
    }
    if (event.ctrlKey && event.keyCode == 80) {
      event.preventDefault();
      newProducts();
    }
    if (event.ctrlKey && event.keyCode == 69) {
      event.preventDefault();
      getCalendarView();
    }
    if (event.ctrlKey && event.keyCode == 72) {
      event.preventDefault();
      getUserMenu();
    }
    if (event.ctrlKey && event.keyCode == 68) {
      event.preventDefault();
      getDashboard();
    }
    if (event.ctrlKey && event.keyCode == 77) {
      event.preventDefault();
      getEdituser();
    }
  });
</script>
