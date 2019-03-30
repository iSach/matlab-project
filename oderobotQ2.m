function dvect = oderobotQ2(t, vect)
% Renvoie un vecteur contenant les derivees des fonctions donnees :
% psi_r(t) : Mouvement sur la roue droite.
% psi_l(t) : Mouvement sur la roue gauche.
% v(t) : Vitesse linéaire du robot
% w(t) : Vitesse angulaire du robot
% theta(t) : Angle du robot avec l'horizontale
% x(t) : Position du robot selon x
% y(t) : Position du robot selon y

    % Différentes valeurs pré-définies utilisés dans les equ. diff.
    e=r_consts.wheel_offset;
    r=r_consts.wheel_radius;
    m=r_consts.robot_mass;
    J=r_consts.robot_intertia;
    c=r_consts.f_friction;
    d=r_consts.d_friction;
    eta=r_consts.reg_param;
    TR=r_consts.right_torque;
    TL=r_consts.left_torque;

    % dvect contient les differentes derivees des fonctions composant le
    % vecteur vect.
    dvect = zeros(7, 1);

    dvect(1) = (1 / r) * (vect(3) + e * vect(4));
    dvect(2) = (1 / r) * (vect(3) - e * vect(4));

    % Introduction de 2 nouvelles valeurs : les forces motrices des roues
    fR = (TR / r) - c * dvect(1) - d * tanh((1 / eta) * dvect(1));
    fL = (TL / r) - c * dvect(2) - d * tanh((1 / eta) * dvect(2));

    dvect(3) = (1 / m) * (fR + fL);
    dvect(4) = (e / J) * (fR - fL);
    dvect(5) = vect(4);
    dvect(6) = vect(3) * cos(vect(5));
    dvect(7) = vect(3) * sin(vect(5));
end
