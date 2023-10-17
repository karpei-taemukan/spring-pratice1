<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <link href="${pageContext.request.contextPath}/resources/users/css/seat.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/users/css/reset.css" rel="stylesheet" /> 
  <title>Movie Seat Booking</title>
</head>

<body>
  <div class="movie-container">
    <label for="movieseat">Movie Choices</label>
    <select id="movieseat">
      <option value="">choice</option>
      <option value="solo">Solo</option>
      <option value="couple">couple</option>
    </select>
    
      <ul class="showcase">
    <li>
      <div class="seatMark notClick"></div>
      <small>Available</small>
    </li>
    <li>
      <div class="seatMark selected"></div>
      <small>Selected</small>
    </li>
    <li>
      <div class="seatMark occupied"></div>
      <small>Occupied</small>
    </li>
  </ul>
  </div>


  <div class="container">
    <div class="screen"></div>
    <div class="bigWrap">
    <ul class="numList">
      <li style="margin-left: 6%">1</li>
      <li>2</li>
      <li style="margin-left: 3%">3</li>
      <li>4</li>
      <li>5</li>
      <li style="margin-left: 1%">6</li>
      <li>7</li>
      <li>8</li>
      <li style="margin-left: 1%">9</li>
      <li>10</li>
      <li>11</li>
      <li>12</li>
      <li>13</li>
      <li>14</li>
    </ul>
    <div class="wrap">
    <ul class="stList">
      <li>A</li>
      <li>B</li>
      <li>C</li>
      <li>D</li>
      <li>E</li>
      <li>F</li>
      <li>G</li>
      <li>H</li>
      <li>I</li>
      <li>J</li>
    </ul>
    <div class="rows">

    <div class="row">
  <div class="seat" data-seat="A1"></div>
  <div class="seat" data-seat="A2"></div>
  <div class="seat occupied" data-seat="A3"></div>
  <div class="seat" data-seat="A4"></div>
  <div class="seat" data-seat="A5"></div>
  <div class="seat" data-seat="A6"></div>
  <div class="seat" data-seat="A7"></div>
  <div class="seat" data-seat="A8"></div>
  <div class="seat" data-seat="A9"></div>
  <div class="seat" data-seat="A10"></div>
  <div class="seat" data-seat="A11"></div>
  <div class="seat" data-seat="A12"></div>
  <div class="seat" data-seat="A13"></div>
  <div class="seat occupied" data-seat="A14"></div>
</div>
<div class="row">
  <div data-seat="B1" class="seat occupied"></div>
  <div data-seat="B2" class="seat occupied"></div>
  <div data-seat="B3" class="seat"></div>
  <div data-seat="B4" class="seat"></div>
  <div data-seat="B5" class="seat"></div>
  <div data-seat="B6" class="seat occupied"></div>
  <div data-seat="B7" class="seat"></div>
  <div data-seat="B8" class="seat"></div>
  <div data-seat="B9" class="seat"></div>
  <div data-seat="B10" class="seat"></div>
  <div data-seat="B11" class="seat"></div>
  <div data-seat="B12" class="seat"></div>
  <div data-seat="B13" class="seat occupied"></div>
  <div data-seat="B14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="C1" class="seat"></div>
  <div data-seat="C2" class="seat"></div>
  <div data-seat="C3" class="seat"></div>
  <div data-seat="C4" class="seat occupied"></div>
  <div data-seat="C5" class="seat occupied"></div>
  <div data-seat="C6" class="seat"></div>
  <div data-seat="C7" class="seat"></div>
  <div data-seat="C8" class="seat"></div>
  <div data-seat="C9" class="seat"></div>
  <div data-seat="C10" class="seat"></div>
  <div data-seat="C11" class="seat"></div>
  <div data-seat="C12" class="seat"></div>
  <div data-seat="C13" class="seat"></div>
  <div data-seat="C14" class="seat occupied"></div>
</div>
<div class="row">
  <div data-seat="D1" class="seat occupied"></div>
  <div data-seat="D2" class="seat"></div>
  <div data-seat="D3" class="seat occupied"></div>
  <div data-seat="D4" class="seat"></div>
  <div data-seat="D5" class="seat"></div>
  <div data-seat="D6" class="seat"></div>
  <div data-seat="D7" class="seat"></div>
  <div data-seat="D8" class="seat"></div>
   <div data-seat="D9" class="seat"></div>
  <div data-seat="D10" class="seat"></div>
  <div data-seat="D11" class="seat"></div>
  <div data-seat="D12" class="seat"></div>
  <div data-seat="D13" class="seat"></div>
  <div data-seat="D14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="E1" class="seat occupied"></div>
  <div data-seat="E2" class="seat"></div>
  <div data-seat="E3" class="seat occupied"></div>
  <div data-seat="E4" class="seat"></div>
  <div data-seat="E5" class="seat"></div>
  <div data-seat="E6" class="seat"></div>
  <div data-seat="E7" class="seat"></div>
  <div data-seat="E8" class="seat"></div>
   <div data-seat="E9" class="seat"></div>
  <div data-seat="E10" class="seat"></div>
  <div data-seat="E11" class="seat"></div>
  <div data-seat="E12" class="seat"></div>
  <div data-seat="E13" class="seat"></div>
  <div data-seat="E14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="F1" class="seat occupied"></div>
  <div data-seat="F2" class="seat"></div>
  <div data-seat="F3" class="seat occupied"></div>
  <div data-seat="F4" class="seat"></div>
  <div data-seat="F5" class="seat"></div>
  <div data-seat="F6" class="seat"></div>
  <div data-seat="F7" class="seat"></div>
  <div data-seat="F8" class="seat"></div>
   <div data-seat="F9" class="seat"></div>
  <div data-seat="F10" class="seat"></div>
  <div data-seat="F11" class="seat"></div>
  <div data-seat="F12" class="seat"></div>
  <div data-seat="F13" class="seat"></div>
  <div data-seat="F14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="G1" class="seat occupied"></div>
  <div data-seat="G2" class="seat"></div>
  <div data-seat="G3" class="seat occupied"></div>
  <div data-seat="G4" class="seat"></div>
  <div data-seat="G5" class="seat"></div>
  <div data-seat="G6" class="seat"></div>
  <div data-seat="G7" class="seat"></div>
  <div data-seat="G8" class="seat"></div>
   <div data-seat="G9" class="seat"></div>
  <div data-seat="G10" class="seat"></div>
  <div data-seat="G11" class="seat"></div>
  <div data-seat="G12" class="seat"></div>
  <div data-seat="G13" class="seat"></div>
  <div data-seat="G14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="H1" class="seat occupied"></div>
  <div data-seat="H2" class="seat"></div>
  <div data-seat="H3" class="seat occupied"></div>
  <div data-seat="H4" class="seat"></div>
  <div data-seat="H5" class="seat"></div>
  <div data-seat="H6" class="seat"></div>
  <div data-seat="H7" class="seat"></div>
  <div data-seat="H8" class="seat"></div>
   <div data-seat="H9" class="seat"></div>
  <div data-seat="H10" class="seat"></div>
  <div data-seat="H11" class="seat"></div>
  <div data-seat="H12" class="seat"></div>
  <div data-seat="H13" class="seat"></div>
  <div data-seat="H14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="I1" class="seat occupied"></div>
  <div data-seat="I2" class="seat"></div>
  <div data-seat="I3" class="seat occupied"></div>
  <div data-seat="I4" class="seat"></div>
  <div data-seat="I5" class="seat"></div>
  <div data-seat="I6" class="seat"></div>
  <div data-seat="I7" class="seat"></div>
  <div data-seat="I8" class="seat"></div>
   <div data-seat="I9" class="seat"></div>
  <div data-seat="I10" class="seat"></div>
  <div data-seat="I11" class="seat"></div>
  <div data-seat="I12" class="seat"></div>
  <div data-seat="I13" class="seat"></div>
  <div data-seat="I14" class="seat"></div>
</div>
<div class="row">
  <div data-seat="J1" class="seat occupied"></div>
  <div data-seat="J2" class="seat"></div>
  <div data-seat="J3" class="seat occupied"></div>
  <div data-seat="J4" class="seat"></div>
  <div data-seat="J5" class="seat"></div>
  <div data-seat="J6" class="seat"></div>
  <div data-seat="J7" class="seat"></div>
  <div data-seat="J8" class="seat"></div>
   <div data-seat="J9" class="seat"></div>
  <div data-seat="J10" class="seat"></div>
  <div data-seat="J11" class="seat"></div>
  <div data-seat="J12" class="seat"></div>
  <div data-seat="J13" class="seat"></div>
  <div data-seat="J14" class="seat"></div>
</div>
</div>
</div></div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script>
  const seats = document.querySelectorAll(".seat");
  const seatopt = document.querySelector("#movieseat");

  const seat_id = document.querySelector(".seat");
   
  let seats_id=[];

  seats.forEach((el) => {
    seats_id.push(el.getAttribute("data-seat"))
  })


  let all_seats = [];
  //console.log(seats_id);
  for(let i=0; i<seats_id.length+1; i++){
    all_seats.push(seats_id.splice(0,14));
  }

  console.log(all_seats);



  function updateSeatSelection(seat) {
    seat.style.background = "green";
    seat.classList.add("noClick");
    seat.style.background="red";
    let seatId = seat.getAttribute("data-seat");
    let seatType = seat.getAttribute("data-seat-type")
  $.ajax({
  type: "get",
  url: "seatReserve",
  data:{
  "seatId" : seatId,
  "seatType" : seatType
  },
  async: false,
  dataType: "json",
  success: function(data){
  console.log(data)
  } 
  });
    console.log(seat.getAttribute("data-seat"));
    console.log(seat.getAttribute("data-seat-type"));
  }

  function updateCoupleSelection(seat1, seat2) {
    seat1.style.background = "green";
    seat2.style.background = "green";
    seat1.classList.add("noClick");
    seat2.classList.add("noClick");
    seat1.style.background="red";
    seat2.style.background="red";

    let seatId = seat1.getAttribute("data-seat")+" "+seat2.getAttribute("data-seat");
 	//console.log(typeof seatId)
 	console.log(seatId)
    let seatType = seat1.getAttribute("data-seat-type")
 	console.log(seatType)
      $.ajax({
    	  type: "get",
    	  url: "seatReserve",
    	  data:{
    	  "seatId" : seatId,
    	  "seatType" : seatType
    	  },
    	  async: false,
    	  dataType: "json",
    	  success: function(data){
    	  console.log(data)
    	  } 
    	  });
   
    console.log(seat1.getAttribute("data-seat"), seat2.getAttribute("data-seat"));
  }

  function removeAllEventListeners() {
    seats.forEach((seat) => {
      seat.removeEventListener("click", soloClickHandler);
      seat.removeEventListener("click", coupleClickHandler);
    });
  }



  function soloClickHandler(event) {
    const select_seat = event.target;

      removeAllEventListeners();


      select_seat.setAttribute("data-seat-type", "solo");
    updateSeatSelection(select_seat);
  }

  function coupleClickHandler(event) {
    removeAllEventListeners();
    const index = Array.from(seats).indexOf(event.target);
    
    if (index < seats.length - 1) {
      const c_getAttr = event.target.getAttribute("data-seat");
      //console.log(c_getAttr);
      const c_getAttr_next = seats[index+1].getAttribute("data-seat");
      //console.log(c_getAttr_next);
      event.target.setAttribute("data-seat-type", "couple");
      seats[index + 1].setAttribute("data-seat-type", "couple");
      updateCoupleSelection(event.target, seats[index + 1]);
    }
  }

  seatopt.addEventListener("change", (e) => {
    // selectedSeats.forEach((seat) => {
    //   seat.style.background = "";
    //   seat.classList.remove("noClick");
    // });


    if (e.target.value === "solo") {
      seats.forEach((seat) => {
        seat.addEventListener("click", soloClickHandler);
      });
    }

    if (e.target.value === "couple") {
      seats.forEach((seat, index) => {
        if (index < seats.length - 1) {
          seat.addEventListener("click", coupleClickHandler);
        }
      });
    }
  });
  </script>
</body>


