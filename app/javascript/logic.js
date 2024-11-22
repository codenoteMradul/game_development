$(document).ready(function(){  
  $("#button").click(function(){ 
    event.preventDefault(); 
    var point = 0
    var random = $("#number")[0].value;
    var value = $("#game").val();  
    var sum = value.split('').reduce(function(total, digit) { return total + parseInt(digit); }, 0);
    if(sum == random){
      point += 50  
      $(".points").text(point);
    }
    else{ 
      point -= 100
      $(".points").text(point);
      window.location.href = '/games/game_over'
      alert("Game Over"); 
    }    
    $.ajax({
      url: '/games/final_point',
      type: 'GET',
      dataType: 'script', 
      data: { point: point},
      success: function(response){
        $(".points").text(response["points"]);
      }
    });   
  });    
});
  



