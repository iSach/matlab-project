% Cherche le zéro d'une fonction donnée dans un intervalle donné à l'aide
% de la méthode de la bissection, avec une certaine précision.
%
% Paramètres :
%   f : La fonction dont on cherche un zéro.
%   lower_bound : Abscisse inférieure
%   upper_bound : Abscisse supérieure
%   err : Précision recherchée. (sur les ordonnées)
function root = bisection(f, lower_bound, upper_bound, err)

    % Si x1 est inférieur à x0, on appelle 
    % la fonction en inversant les bornes pour
    % que x0 soit bien inférieur à x1.
    if upper_bound < lower_bound 
        root = bisection(f, upper_bound, lower_bound, err);
        return;
    end

    % Vérifie si les bornes sont de signes opposés.
    if f(lower_bound) * f(upper_bound) > 0
        error('Bornes non correctes, il faut une borne positive, et une negative')
    end
    
    mid = 0;
    mid_y = f((lower_bound + upper_bound) / 2);
    i = 0; % Nombre d'itérations.

    % Recherche du zéro
    while abs(mid_y) > err && i < 100
        
        low_y = f(lower_bound);
        up_y = f(upper_bound);
       
        % On vérifie si on a atteint la précision voulue en la borne
        % inférieure.
        if abs(low_y) <= err
            root = lower_bound;
            return;
        end

        % On vérifie si on a atteint la précision voulue en la borne
        % supérieure.
        if abs(up_y) <= err 
            root = upper_bound;
            return;
        end
        
        % On prend le milieu de l'intervalle et le définit comme étant la
        % nouvelle borne supérieure (ou inférieure) selon le signe de la
        % fonction en cette abscisse.
        mid = (upper_bound + lower_bound) / 2;
        
        mid_y = f(mid);
       
        if mid_y * up_y > 0
            upper_bound = mid;
        else
            lower_bound = mid;
        end
            
        % On vérifie si l'ordonnée en b répond à la précision voulue, si
        % oui on retourne b comme étant la racine approximative.
        if abs(mid_y) <= err
            root = mid;
            return;
        end
        
        i = i + 1;
    end
    
    if abs(f(mid)) > err
        % Aucune racine n'a été trouvée.
        error('Pas de racine dans cet intervalle.')
    end
end