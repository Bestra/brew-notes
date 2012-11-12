
$ ->
  # DOMContentLoaded
  $("tr.fermentable_entry").each (index,element) ->
    ppg = $(element).find(".ppg").text()
    amount = $(element).find(".amount").text()
    points = calculatePoints(amount,ppg)
    $(element).find(".points").text(points)
    volume = $("span#volume").text()
    og = $("span#og").text()
    $(element).find(".percent_og").text(Math.round(percentOG(points, volume, og) * 100))
    


calculatePoints = (amount,ppg) ->
  amount * ppg / 16

percentOG = (points, volume, og) ->
  totalPoints = volume * (og - 1) * 1000
  points / totalPoints



  
