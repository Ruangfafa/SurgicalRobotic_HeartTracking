classdef ControlUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        mecaControl               matlab.ui.Figure
        DoZeroButton              matlab.ui.control.Button
        WithConstraintCheckBox    matlab.ui.control.CheckBox
        Inverse3ControlCheckBox   matlab.ui.control.CheckBox
        MovingRelativelyCheckBox  matlab.ui.control.CheckBox
        zAxisButtonGroup          matlab.ui.container.ButtonGroup
        zPlusButton               matlab.ui.control.RadioButton
        zZeroButton               matlab.ui.control.RadioButton
        zMinusButton              matlab.ui.control.RadioButton
        yAxisButtonGroup          matlab.ui.container.ButtonGroup
        yPlusButton               matlab.ui.control.RadioButton
        yZeroButton               matlab.ui.control.RadioButton
        yMinusButton              matlab.ui.control.RadioButton
        xAxisButtonGroup          matlab.ui.container.ButtonGroup
        xPlusButton               matlab.ui.control.RadioButton
        xZeroButton               matlab.ui.control.RadioButton
        xMinusButton              matlab.ui.control.RadioButton
        ZSpeedSlider              matlab.ui.control.Slider
        ZSpeedSliderLabel         matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: not associated with a component
        function moveZ(app, event)
            selectedButton = app.zAxisButtonGroup.SelectedObject;
            
        end

        % Callback function: not associated with a component
        function moveY(app, event)
            selectedButton = app.yAxisButtonGroup.SelectedObject;
            
        end

        % Callback function: not associated with a component
        function moveX(app, event)
            selectedButton = app.xAxisButtonGroup.SelectedObject;
            
        end

        % Callback function: not associated with a component
        function updateZSpeed(app, event)
            value = app.ZSpeedSlider.Value;
            
        end

        % Callback function: not associated with a component
        function movi(app, event)
            value = app.MovingRelativelyCheckBox.Value;
            
        end

        % Callback function: not associated with a component
        function relativeMotion(app, event)
            value = app.MovingRelativelyCheckBox.Value;
            
        end

        % Callback function: not associated with a component
        function changeControlOption(app, event)
            value = app.Inverse3ControlCheckBox.Value;
            
        end

        % Callback function: not associated with a component
        function xAxisButtonGroupSelectionChanged(app, event)
            selectedButton = app.xAxisButtonGroup.SelectedObject;
            
        end

        % Callback function: not associated with a component
        function changeConstraintOption(app, event)
            value = app.WithConstraintCheckBox.Value;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create mecaControl and hide until all components are created
            app.mecaControl = uifigure('Visible', 'off');
            app.mecaControl.Position = [100 100 386 368];
            app.mecaControl.Name = 'MATLAB App';

            % Create ZSpeedSliderLabel
            app.ZSpeedSliderLabel = uilabel(app.mecaControl);
            app.ZSpeedSliderLabel.HorizontalAlignment = 'right';
            app.ZSpeedSliderLabel.Position = [18 128 50 22];
            app.ZSpeedSliderLabel.Text = 'Z Speed';

            % Create ZSpeedSlider
            app.ZSpeedSlider = uislider(app.mecaControl);
            app.ZSpeedSlider.Position = [89 137 213 3];
            app.ZSpeedSlider.Value = 5;

            % Create xAxisButtonGroup
            app.xAxisButtonGroup = uibuttongroup(app.mecaControl);
            app.xAxisButtonGroup.Title = 'x axis:';
            app.xAxisButtonGroup.Position = [18 304 130 49];

            % Create xMinusButton
            app.xMinusButton = uiradiobutton(app.xAxisButtonGroup);
            app.xMinusButton.Text = '-';
            app.xMinusButton.Position = [11 3 58 22];

            % Create xZeroButton
            app.xZeroButton = uiradiobutton(app.xAxisButtonGroup);
            app.xZeroButton.Text = '0';
            app.xZeroButton.Position = [47 3 65 22];
            app.xZeroButton.Value = true;

            % Create xPlusButton
            app.xPlusButton = uiradiobutton(app.xAxisButtonGroup);
            app.xPlusButton.Text = '+';
            app.xPlusButton.Position = [88 3 65 22];

            % Create yAxisButtonGroup
            app.yAxisButtonGroup = uibuttongroup(app.mecaControl);
            app.yAxisButtonGroup.Title = 'y axis:';
            app.yAxisButtonGroup.Position = [18 241 130 49];

            % Create yMinusButton
            app.yMinusButton = uiradiobutton(app.yAxisButtonGroup);
            app.yMinusButton.Text = '-';
            app.yMinusButton.Position = [11 3 58 22];

            % Create yZeroButton
            app.yZeroButton = uiradiobutton(app.yAxisButtonGroup);
            app.yZeroButton.Text = '0';
            app.yZeroButton.Position = [47 3 65 22];
            app.yZeroButton.Value = true;

            % Create yPlusButton
            app.yPlusButton = uiradiobutton(app.yAxisButtonGroup);
            app.yPlusButton.Text = '+';
            app.yPlusButton.Position = [88 3 65 22];

            % Create zAxisButtonGroup
            app.zAxisButtonGroup = uibuttongroup(app.mecaControl);
            app.zAxisButtonGroup.Title = 'z axis:';
            app.zAxisButtonGroup.Position = [18 176 130 49];

            % Create zMinusButton
            app.zMinusButton = uiradiobutton(app.zAxisButtonGroup);
            app.zMinusButton.Text = '-';
            app.zMinusButton.Position = [11 3 58 22];

            % Create zZeroButton
            app.zZeroButton = uiradiobutton(app.zAxisButtonGroup);
            app.zZeroButton.Text = '0';
            app.zZeroButton.Position = [47 3 65 22];
            app.zZeroButton.Value = true;

            % Create zPlusButton
            app.zPlusButton = uiradiobutton(app.zAxisButtonGroup);
            app.zPlusButton.Text = '+';
            app.zPlusButton.Position = [88 3 65 22];

            % Create MovingRelativelyCheckBox
            app.MovingRelativelyCheckBox = uicheckbox(app.mecaControl);
            app.MovingRelativelyCheckBox.Text = 'Moving Relatively';
            app.MovingRelativelyCheckBox.Position = [18 54 116 22];

            % Create Inverse3ControlCheckBox
            app.Inverse3ControlCheckBox = uicheckbox(app.mecaControl);
            app.Inverse3ControlCheckBox.Text = 'Inverse3 Control';
            app.Inverse3ControlCheckBox.Position = [18 33 110 22];

            % Create WithConstraintCheckBox
            app.WithConstraintCheckBox = uicheckbox(app.mecaControl);
            app.WithConstraintCheckBox.Text = 'With Constraint';
            app.WithConstraintCheckBox.Position = [18 12 104 22];

            % Create DoZeroButton
            app.DoZeroButton = uibutton(app.mecaControl, 'push');
            app.DoZeroButton.Position = [18 74 100 23];
            app.DoZeroButton.Text = 'Do Zero';

            % Show the figure after all components are created
            app.mecaControl.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ControlUI

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.mecaControl)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.mecaControl)
        end
    end
end