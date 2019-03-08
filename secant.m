% Cherche le z�ro d'une fonction donn�e dans un intervalle donn� � l'aide
% de la m�thode de la s�cante.
%
% Param�tres :
%   f : La fonction dont on cherche un z�ro.
%   low : Abscisse de la borne inf�rieure
%   up : Abscisse de la borne sup�rieure
function root = secant(f, low, up)

    % Si x1 est inf�rieur � x0, on appelle 
    % la fonction en inversant les bornes pour
    % que x0 soit bien inf�rieur � x1.
    if up < low 
        root = secant(f, up, low);
        return;
    end
    
    % On pr�-calcule les ordonn�es des bornes pour �viter des appels
    % inutiles de la fonction.
    low_y = f(low);
    up_y = f(up);
    
    % On d�finit la tol�rance d'erreur.
    err = 10^(-4);
    
    % Si l'ordonn�e de la borne inf�rieure est assez proche de 0, on
    % renvoie la borne inf�rieure comme racine.
    if abs(low_y) <= err
        root = low;
        return;
    end
    
    % Si l'ordonn�e de la borne sup�rieure est assez proche de 0, on
    % renvoie la borne sup�rieure comme racine.
    if abs(up_y) <= err
        root = up;
        return;
    end
    
    original_low = low;
    original_up = up;
    
    % Calcul de la droite et de son z�ro.
    m = (up_y - low_y) / (up - low);
    p = low_y - m * low;
    b = -(p / m);
    low = b;
    
    problem = 0;
    min_slope = 0.05;
    
    % Direction de la recherche via la m�thode de la s�cante
    % 1 = Sens classique (en partant du point sup�rieur)
    % 0 = Sens inverse (en partant du point inf�rieur)
    direction = 1;
        
    % La boucle tourne tant que le z�ro ne rencontre pas la tol�rance
    % voulue.
    while abs(f(b)) > err
    
        low_y = f(low);
        up_y = f(up);
        
        if(isinf(low_y) || isinf(up_y))
            error('Pas de convergence de la s�cante.')
        end
        
        % Arrive si le z�ro de la s�cante se trouve hors du domaine de
        % d�finition de la fonction. Dans ce cas, on peut tenter de
        % corriger en effectutant la recherche dans l'autre sens.
        if(isnan(low_y) || ~isreal(low_y))
            disp('Erreur. Tentative de correction. (Changement de sens de la recherche)');
            low = original_low;
            up = original_up;
            low_y = f(low);
            up_y = f(up);
            m = (up_y - low_y) / (up - low);
            p = low_y - m * low;
            b = -(p / m);
            up = b;
            direction = 0;
            continue;
        end
        
        m = (up_y - low_y) / (up-low);
        p = low_y - m * low;
        b = -(p / m);
        
        if(direction)
            low = b;
        else
            up = b;
        end
  
        % On v�rifie si la convergence de la pente n'est pas trop faible,
        % si elle l'est, on pr�vient d'un �ventuel ralentissement de la
        % recherche de z�ro. L'utilisateur sera alors libre d'annuler la
        % recherche ou non.
        if problem < 150
            if m < min_slope
                problem = problem + 1;
            else
                problem = 0;
            end
            if problem == 10
                disp('Attention : Faible convergence. La recherche peut etre lente.')
            elseif problem == 50
                disp('Attention : Tres faible convergence ! La recherche sera longue.')
            elseif problem == 150
                disp('Attention : Extremement faible convergence !! La recherche sera tres longue !')
            end
        end
    end
    
    if abs(f(b)) > err
        error('Aucune racine n''a ete trouvee dans cet intervalle')
    end
    
    root = b;
end
