classdef r_consts
   properties (Constant)
      % Question 1 : Bissection et secante 
      
      
      % Question 2 : Modelisation et simulation
      sys_init_cond = 1 + zeros(7, 1); % C.I. du systeme différentiel
      sys_final_time = 20;         % Temps final pour le sys. diff.
      euler_gap = 0.01;            % Ecart entre les itérations d'Euler exp
      wheel_offset = 0.15;         % dist entre roue et centre du robot
      wheel_radius = 0.1;          % rayon de chaque roue
      robot_mass = 10;             % Masse totale du robot
      robot_intertia = 1;          % Intertie du robot
      f_friction = 0.01;           % Coeff de frottement visqueux
      d_friction = 0.8;            % Coeff de frottement sec
      reg_param = 0.1;             % Param. de régularisation du frottement
      right_torque = 1.1;          % Couple moteur droit
      left_torque = 1;             % Couple moteur gauche
      init_cond = zeros(7,1);      % Conditions initiales des equ. diff
      
      % Question 3 : Planification de la trajectoire
      traj_time_values = 0:4;       % Ordonnees des points de passage
      traj_x_values = [0 1 5 6 8];  % Pts de passage selon x
      traj_y_values = [0 -1 1 5 4]; % Pts de passage selon y
      wheel_mov_grid = 101; % Nombre de sous-divisions de la grille.
      init_psir = 0;
      init_psil = 0;
      
      % Question 4 : Suivi et optimisation de la trajectoire
      mov_angle_epsilon = 10^-6;
      sys_gain = 100;
      final_time = 4; % Temps final 
   end
end