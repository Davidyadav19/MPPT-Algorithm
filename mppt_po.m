function duty = mppt_po(V, I, delta_in)
    % Persistent variables to store previous voltage, current, and duty cycle
    
    duty_init=0.05;
    duty_min=0;
    duty_max=0.75;

    persistent V_old P_old duty_old;
    if isempty(V_old)
        V_old = 0;
        P_old = 0;
        duty_old = duty_init; % Initialize duty cycle to 50%
    end

    % Calculate current power and previous power
    P = V*I;
    dv=V-V_old;
    dp=P-P_old;
    duty=duty_old;
    Delta_D=delta_in;




    % Perturbation and Observe algorithm
    if dp ~= 0
        if dp < 0
            if dv<0
                duty = duty_old - Delta_D; % Increase duty cycle
            else
                 duty = duty_old + Delta_D;
           ; % Decrease duty cycle
        end
    else
        if dv < 0
            duty = duty_old + Delta_D; % Decrease duty cycle
        else
            duty = duty_old - Delta_D; % Increase duty cycle
        end
    end

    % Limit duty cycle to [0, 1]
    if duty >= duty_max
        duty=duty_max;
    elseif duty < duty_min
        duty=duty_min
    end



    % Update previous values
    V_old = V;
    P_old = P;
    duty_old = duty;
  end 
