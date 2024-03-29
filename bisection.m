% Cherche le z�ro d'une fonction donn�e dans un intervalle donn� � l'aide
% de la m�thode de la bissection, avec une certaine pr�cision.
%
% Param�tres :
%   f : La fonction dont on cherche un z�ro.
%   lower_bound : Abscisse inf�rieure
%   upper_bound : Abscisse sup�rieure
%   err : Pr�cision recherch�e. (sur les ordonn�es)
function root = bisection(f, lower_bound, upper_bound, err)

    % Si x1 est inf�rieur � x0, on appelle 
    % la fonction en inversant les bornes pour
    % que x0 soit bien inf�rieur � x1.
    if upper_bound < lower_bound 
        root = bisection(f, upper_bound, lower_bound, err);
        return;
    end

    % V�rifie si les bornes sont de signes oppos�s.
    if f(lower_bound) * f(upper_bound) > 0
        error('Bornes non correctes, il faut une borne positive, et une negative')
    end
    
    % On initialise les variables pour la boucle
    mid = 0;
    % On initialise � une valeur > err pour pouvoir commencer la boucle.
    % Cette valeur est calcul�e � chaque it�ration.
    mid_y = err + 1; 
    i = 0;
    max_iterations = 100; % On d�finit un nombre maximum d'it�rations
    
    % Recherche du z�ro
    while abs(mid_y) > err && i < max_iterations 
        
        low_y = f(lower_bound);
        up_y = f(upper_bound);
        
        % On v�rifie d'abord que les bornes ne peuvent pas �tre consid�r�s
        % comme des racines.
        if abs(low_y) <= err
            root = lower_bound;
            return;
        end
        if abs(up_y) <= err
            root = upper_bound;
            return;
        end
        
        % On prend ensuite le milieu de l'intervalle et le d�finit comme
        % �tant la nouvelle borne sup�rieure (ou inf�rieure) selon le signe
        % de la fonction en cette abscisse.
        mid = (upper_bound + lower_bound) / 2;
        mid_y = f(mid);
       
        % On v�rifie si l'ordonn�e en b r�pond � la pr�cision voulue, si
        % oui on retourne b comme �tant la racine approximative.
        if abs(mid_y) <= err
            root = mid;
            return;
        end
        
        if mid_y * up_y > 0
            upper_bound = mid;
        else
            lower_bound = mid;
        end
        
        i = i + 1;
    end
    
    root = NaN;
    % Aucune racine n'a �t� trouv�e.
    error('Pas de racine dans cet intervalle.')
end