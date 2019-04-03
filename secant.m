function root = secantv2(f, low_x, up_x)
% Approxime un zéro d'une fonction via la méthode de la sécante.
% Elle cherche ce zéro à l'aide d'une succession de zéros de droites.
%
% Bien que la fonction demande au départ deux approximations initiales, le
% zéro trouvé peut très bien se trouver hors de ces "bornes". 
%
% Paramètres :
% f     : La fonction dont on cherche un zéro
% low_x : Abscisse de l'approximation initiale inférieure.
% up_x  : Abscisse de l'approximation initiale supérieure.

    % On récupère la valeur de la tolérance d'erreur.
    % C'est à dire l'erreur qu'on accepte sur l'axe des ordonnées,
    % Car il est très improbable que la sécante trouve la racine exacte.
    tolerance = r_consts.secant_error_tolerance;
    
    % Gardien, c'est-à-dire le nombre le maximum d'itérations, afin
    % d'éviter que la fonction ne cherche indéfiniment des
    max_iterations = 100;

    % On s'assure, pour une question de praticité, que low < up. 
    if low_x > up_x
        root = secantv2(f, up_x, low_x);
        return;
    end
    
    % On calcule les ordonnées des bornes initiales.
    low_y = f(low_x);
    up_y = f(up_x);
    
    % On vérifie que les deux bornes n'ont pas la même ordonnée.
    % Si c'est le cas, la droite les joignants n'a pas d'intersection avec
    % l'axe des abscisses.
    if low_y == up_y
        root = NaN;
        disp('Erreur, les ordonnées des bornes sont égales.')
        return;
    end
    
    % On vérifie si la borne inférieure 
    % ne peut pas déjà être considérée comme une racine.
    % La même vérification pour la borne supérieure est effectuée
    % a chaque itération de la boucle.
    if abs(low_y) <= tolerance
        root = low_x;
        return;
    end
    
    % Ces 2 vecteurs contiennent les abscisses et ordonnées des 2 points
    % précédents. Initialement, ce sont respectivement la borne inférieure
    % et la borne supérieure. A chaque itération, la borne inférieure est
    % remplacée par la borne supérieure, et la supérieure par la nouvelle
    % abscisse calculée.
    prev_x = [low_x up_x];
    prev_y = [low_y up_y];
    
    for i = 1:max_iterations
        % On vérifie ici si notre borne supérieure peut être
        % considérée comme une raicine, i.e. si son ordonnée ne dépasse
        % pas la tolérance d'erreur.
        % La 1re vérification vérifie la borne supérieure initiale, et
        % les vérifications suivantes le dernier point calculé (qui
        % remplace la borne supérieure précédente)
        if abs(prev_y(2)) <= tolerance
            root = prev_x(2);
            return;
        end
        
        % On calcule la nouvelle abscisse.
        new_x = prev_x(2) - ...
            (prev_y(2) * (prev_x(2) - prev_x(1))) ...
            / (prev_y(2) - prev_y(1));
        
        % On vérifie si la nouvelle valeur a bien été calculée.
        % Le cas échéant, on arrête la boucle.
        if isnan(new_x)
           break; 
        end
        
        new_y = f(new_x);
        
        % Si la nouvelle abscisse 
        if ~isreal(new_y)
            break;
        end
        
        % Borne inf := borne sup
        % Borne sup := new_x
        % De même pour les ordonnées.
        prev_x(1) = prev_x(2);
        prev_x(2) = new_x;
        prev_y(1) = prev_y(2);
        prev_y(2) = new_y;
    end
    
    % Si, après la boucle, la dernière abscisse calculée ne possède pas
    % une ordonnée suffisamment petite, on retourne NaN puisqu'on n'a pas
    % alors trouvé une racine acceptable.
    if abs(prev_y(2)) > tolerance
        root = NaN;
        fprintf('La méthode de la sécante n''a pas pu trouvé de racine avec\n les approximations initiales données.')
        return;
    end

    root = prev_x(2); 
end