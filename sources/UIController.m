classdef UIController < ControlUI
    % Intermediator of backend logic and the GUI
    % Catch the user action
    properties
        m
        uiView
        xRadioButtons
        yRadioButtons
        zRadioButtons
        zeroEnable  % if the do zero button is clicked, it then set to unable until the do zero action has completed
    end
    
    methods (Access = public)
        % Constructor - sync global value in Main.m
        function app = UIController(fileName, format)
            app.m = memmapfile(fileName, 'Format', format, 'Writable', true);
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
            app.mecaControl.CloseRequestFcn = createCallbackFcn(app, @closeApp, true);
            app.mecaControl.KeyPressFcn = createCallbackFcn(app, @keyPressControl, true);
            app.mecaControl.KeyReleaseFcn = createCallbackFcn(app, @keyReleaseControl, true);
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
            app.m.Data.meca_moveX = syncRadioButtonAndValue(app, text);
        end

        function moveY(app, event)
            text = app.yAxisButtonGroup.SelectedObject.Text;
            app.m.Data.meca_moveY = syncRadioButtonAndValue(app, text);
        end

        function moveZ(app, event)
            text = app.zAxisButtonGroup.SelectedObject.Text;
            app.m.Data.meca_moveZ = syncRadioButtonAndValue(app, text);
        end

        function updateZSpeed(app, event)
            app.m.Data.meca_moveZSpeed = app.ZSpeedSlider.Value;
        end

        function doZero(app, event)
            app.m.Data.haply_meca_doZero = 1;
        end

        function relativeMotion(app, event) 
            app.m.Data.meca_rangefinder_zAxisRelativelyStill = double(app.MovingRelativelyCheckBox.Value);
        end

       function useInverse3(app, event)
            app.m.Data.haply_meca_moveOption = double(app.Inverse3ControlCheckBox.Value);
       end

       function useConstraint(app, event)
            app.m.Data.haply_meca_constraint = double(app.WithConstraintCheckBox.Value);
       end

       function closeApp(app, event)
           app.m.Data.systemOn = 0;
           delete(app)
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

        function keyPressControl(app, event)
            pressedKey = event.Key;
            switch pressedKey
                case 'a'
                    app.yMinusButton.Value = 1;
                    moveY(app, event);
                case 'd'
                    app.yPlusButton.Value = 1;
                    moveY(app, event);
                case 'w'
                    app.xPlusButton.Value = 1;
                    moveX(app, event);
                case 's'
                    app.xMinusButton.Value = 1;
                    moveX(app, event);
                case 'rightarrow'
                    app.zPlusButton.Value = 1;
                    moveZ(app, event);
                case 'leftarrow'
                    app.zMinusButton.Value = 1;
                    moveZ(app, event);
            end
        end

        function keyReleaseControl(app, event)
            releasedKey = event.Key;
            switch releasedKey
                case 'a'
                    app.yZeroButton.Value = 1;
                    moveY(app, event);
                case 'd'
                    app.yZeroButton.Value = 1;
                    moveY(app, event);
                case 'w'
                    disp('release w');
                    app.xZeroButton.Value = 1;
                    moveX(app, event);
                case 's'
                    app.xZeroButton.Value = 1;
                    moveX(app, event);
                case 'rightarrow'
                    app.zZeroButton.Value = 1;
                    moveZ(app, event);
                case 'leftarrow'
                    app.zZeroButton.Value = 1;
                    moveZ(app, event);
            end
        end
    end
end
