classdef UIController < ControlUI
    % Intermediator of backend logic and the GUI
    % Catch the user action
    properties
        uiView
        xRadioButtons
        yRadioButtons
        zRadioButtons
        zeroEnable  % if the do zero button is clicked, it then set to unable until the do zero action has completed
    end
    
    methods (Access = public)
        % Constructor - sync global value in Main.m
        function app = UIController()
            % uiView = ControlUI();
            % xRadioButtons = {uiView.xMinusButton, uiView.xZeroButton, uiView.xPlusButton};
            % yRadioButtons = {uiView.yMinusButton, uiView.yZeroButton, uiView.yPlusButton};
            % zRadioButtons = {uiView.zMinusButton, uiView.zZeroButton, uiView.zPlusButton};
            % 
            % sync axis control value
            % uiView.xAxisButtonGroup.SelectedObject = xRadioButtons{a};
            % uiView.yAxisButtonGroup.SelectedObject = yRadioButtons{getTargetRadioButton(meca_moveY)};
            % uiView.zAxisButtonGroup.SelectedObject = zRadioButtons{getTargetRadioButton(meca_moveZ)};
            % sync slider, button and checkbox
            % uiView.ZSpeedSlider.Value = zSpeed;

            % connect action
            app.xAxisButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @moveX, true);
            app.yAxisButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @moveY, true);
            app.zAxisButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @moveZ, true);
            app.ZSpeedSlider.ValueChangedFcn = createCallbackFcn(app, @updateZSpeed, true);
            app.DoZeroButton.ButtonPushedFcn = createCallbackFcn(app, @doZero, true);
            app.MovingRelativelyCheckBox.ValueChangedFcn = createCallbackFcn(app, @relativeMotion, true);
            app.Inverse3ControlCheckBox.ValueChangedFcn = createCallbackFcn(app, @useInverse3, true);
            app.WithConstraintCheckBox.ValueChangedFcn = createCallbackFcn(app, @useConstraint, true);
            
        end
    % end
    % 
    % methods (Access = private)
        
        % Return target radio button index - 1: -, 2: 0, 3: +
        function selectedButtonIndex = getTargetRadioButton(value)
            if value > 0
                selectedButtonIndex = 3;
            elseif value < 0
                selectedButtonIndex = 1;
            else
                selectedButtonIndex = 2;
            end
        end
        
        % If the value for check box is neither 1 or 0, update to a valid
        % value
        function val = checkCheckBoxVal(value)
            if value > 0
                val = 1;
            else
                val = 0;
            end
        end

        function moveX(app, event)
            text = app.xAxisButtonGroup.SelectedObject.Text;
            global meca_moveX
            meca_moveX = syncRadioButtonAndValue(app, text);
        end

        function moveY(app, event)
            text = app.yAxisButtonGroup.SelectedObject.Text;
            global meca_moveY
            meca_moveY = syncRadioButtonAndValue(app, text);
        end

        function moveZ(app, event)
            text = app.zAxisButtonGroup.SelectedObject.Text;
            global meca_moveZ
            meca_moveZ = syncRadioButtonAndValue(app, text);
        end

        function updateZSpeed(app, event)
            value = app.ZSpeedSlider.Value;
            global meca_moveZSpeed
            meca_moveZSpeed = value;
        end

        function doZero(app, event)
            global haply_meca_doZero
            haply_meca_doZero = true;
        end

        function relativeMotion(app, event) 
            disp(app.MovingRelativelyCheckBox.Value)
            global meca_rangefinder_zAxisRelativelyStill
            meca_rangefinder_zAxisRelativelyStill = app.MovingRelativelyCheckBox.Value;
        end

       function useInverse3(app, event)
            global haply_meca_moveOption
            haply_meca_moveOption = app.Inverse3ControlCheckBox.Value;
       end

       function useConstraint(app, event)
            global haply_meca_constraint
            haply_meca_constraint = app.WithConstraintCheckBox.Value;
        end


        function val = syncRadioButtonAndValue(app, text)
            if text == "-"
                val = -1;
            elseif text == "+"
                val = 1;
            else
                val = 0;
            end
        end
    end
end
