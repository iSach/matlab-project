% Cherche le zéro d'une fonction donnée dans un intervalle donné à l'aide
% de la méthode de la sécante.
%
% Paramètres :
%   f : La fonction dont on cherche un zéro.
%   low : Abscisse de la borne inférieure
%   up : Abscisse de la borne supérieure
function root = secant(f, low, up)

    % Si x1 est inférieur à x0, on appelle 
    % la fonction en inversant les bornes pour
    % que x0 soit bien inférieur à x1.
    if up < low 
        root = secant(f, up, low);
        return;
    end
    
    % On pré-calcule les ordonnées des bornes pour éviter des appels
    % inutiles de la fonction.
    low_y = f(low);
    up_y = f(up);
    
    % On définit la tolérance d'erreur.
    err = 10^(-4);
    
    % Si l'ordonnée de la borne inférieure est assez proche de 0, on
    % renvoie la borne inférieure comme racine.
    if abs(low_y) <= err
        root = low;
        return;
    end
    
    % Si l'ordonnée de la borne supérieure est assez proche de 0, on
    % renvoie la borne supérieure comme racine.
    if abs(up_y) <= err
        root = up;
        return;
    end
    
    original_low = low;
    original_up = up;
    
    % Calcul de la droite et de son zéro.
    m = (up_y - low_y) / (up - low);
    p = low_y - m * low;
    b = -(p / m);
    low = b;
    
    problem = 0;
    min_slope = 0.05;
    
    % Direction de la recherche via la méthode de la sécante
    % 1 = Sens classique (en partant du point supérieur)
    % 0 = Sens inverse (en partant du point inférieur)
    direction = 1;
        
    % La boucle tourne tant que le zéro ne rencontre pas la tolérance
    % voulue.
    while abs(f(b)) > err
    
        low_y = f(low);
        up_y = f(up);
        
        if(isinf(low_y) || isinf(up_y))
            error('Pas de convergence de la sécante.')
        end
        
        % Arrive si le zéro de la sécante se trouve hors du domaine de
        % définition de la fonction. Dans ce cas, on peut tenter de
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
  
        % On vérifie si la convergence de la pente n'est pas trop faible,
        % si elle l'est, on prévient d'un éventuel ralentissement de la
        % recherche de zéro. L'utilisateur sera alors libre d'annuler la
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
