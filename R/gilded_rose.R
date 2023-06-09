source('item.R')

update_quality <- function(items) {
  lapply(items, 
    function(item) {
      
      if (item$name != "Aged Brie" && item$name != "Backstage passes") {
        if (item$quality > 0) {
          if (item$name != "Diamond") {
            item$quality <- item$quality - 1
          }
        }
      } else {
        if (item$quality < 50) {
          item$quality <- item$quality + 1
          if (item$name == "Backstage passes") {
            if (item$sell_in < 11) {
              if (item$quality < 50) {
                item$quality = item$quality + 1
              }
            }
            if (item$sell_in < 6) {
              if (item$quality < 50) {
                item$quality = item$quality + 1
              }
            }
          }
        }
      }
      
      if (item$name != "Diamond") {
        item$sell_in <- item$sell_in - 1
      }
      
      if (item$sell_in < 0) {
        if (item$name != "Aged Brie") {
          if (item$name != "Backstage passes") {
            if (item$quality > 0) {
              if (item$name != "Diamond") {
                item$quality <- item$quality - 1
              }
            }
          } else {
            item$quality <- item$quality - item$quality
          }
        } else {
          if (item$quality < 50) {
            item$quality <- item$quality + 1
          }
        }
      }
      
      item
    } 
  ) 
}
