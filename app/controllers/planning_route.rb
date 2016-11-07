class PlanningRoute
    attr_accessor:hash_value
    def init(hash_value=nil)#hash_value should be a hash object
        @hash_value=hash_value
    end

    def summary_update()
        #recalculate all the duration and distance of the whole route
    end
    
    def reset()
        @hash_value.clear    
    end
    
    def add(comment_not_used,route)
        steps_1=@hash_value[:legs]
        steps_2=route[:legs]
        @hash_value[:legs]=steps_1.merge(steps_2){ |key,oldval,newval| oldval | newval }#suppose this is right
        summary_update()
    end
    

  
end