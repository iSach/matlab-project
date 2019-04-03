function root = secantv2(f, low_x, up_x)
% Approxime un z�ro d'une fonction via la m�thode de la s�cante.
% Elle cherche ce z�ro � l'aide d'une succession de z�ros de droites.
%
% Bien que la fonction demande au d�part deux approximations initiales, le
% z�ro trouv� peut tr�s bien se trouver hors de ces "bornes". 
%
% Param�tres :
% f     : La fonction dont on cherche un z�ro
% low_x : Abscisse de l'approximation initiale inf�rieure.
% up_x  : Abscisse de l'approximation initiale sup�rieure.

    % On r�cup�re la valeur de la tol�rance d'erreur.
    % C'est � dire l'erreur qu'on accepte sur l'axe des ordonn�es,
    % Car il est tr�s improbable que la s�cante trouve la racine exacte.
    tolerance = r_consts.secant_error_tolerance;
    
    % Gardien, c'est-�-dire le nombre le maximum d'it�rations, afin
    % d'�viter que la fonction ne cherche ind�finiment des
    max_iterations = 100;

    % On s'assure, pour une question de praticit�, que low < up. 
    if low_x > up_x
        root = secantv2(f, up_x, low_x);
        return;
    end
    
    % On calcule les ordonn�es des bornes initiales.
    low_y = f(low_x);
    up_y = f(up_x);
    
    % On v�rifie que les deux bornes n'ont pas la m�me ordonn�e.
    % Si c'est le cas, la droite les joignants n'a pas d'intersection avec
    % l'axe des abscisses.
    if low_y == up_y
        root = NaN;
        disp('Erreur, les ordonn�es des bornes sont �gales.')
        return;
    end
    
    % On v�rifie si la borne inf�rieure 
    % ne peut pas d�j� �tre consid�r�e comme une racine.
    % La m�me v�rification pour la borne sup�rieure est effectu�e
    % a chaque it�ration de la boucle.
    if abs(low_y) <= tolerance
        root = low_x;
        return;
    end
    
    % Ces 2 vecteurs contiennent les abscisses et ordonn�es des 2 points
    % pr�c�dents. Initialement, ce sont respectivement la borne inf�rieure
    % et la borne sup�rieure. A chaque it�ration, la borne inf�rieure est
    % remplac�e par la borne sup�rieure, et la sup�rieure par la nouvelle
    % abscisse calcul�e.
    prev_x = [low_x up_x];
    prev_y = [low_y up_y];
    
    for i = 1:max_iterations
        % On v�rifie ici si notre borne sup�rieure peut �tre
        % consid�r�e comme une raicine, i.e. si son ordonn�e ne d�passe
        % pas la tol�rance d'erreur.
        % La 1re v�rification v�rifie la borne sup�rieure initiale, et
        % les v�rifications suivantes le dernier point calcul� (qui
        % remplace la borne sup�rieure pr�c�dente)
        if abs(prev_y(2)) <= tolerance
            root = prev_x(2);
            return;
        end
        
        % On calcule la nouvelle abscisse.
        new_x = prev_x(2) - ...
            (prev_y(2) * (prev_x(2) - prev_x(1))) ...
            / (prev_y(2) - prev_y(1));
        
        % On v�rifie si la nouvelle valeur a bien �t� calcul�e.
        % Le cas �ch�ant, on arr�te la boucle.
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
        % De m�me pour les ordonn�es.
        prev_x(1) = prev_x(2);
        prev_x(2) = new_x;
        prev_y(1) = prev_y(2);
        prev_y(2) = new_y;
    end
    
    % Si, apr�s la boucle, la derni�re abscisse calcul�e ne poss�de pas
    % une ordonn�e suffisamment petite, on retourne NaN puisqu'on n'a pas
    % alors trouv� une racine acceptable.
    if abs(prev_y(2)) > tolerance
        root = NaN;
        fprintf('La m�thode de la s�cante n''a pas pu trouv� de racine avec\n les approximations initiales donn�es.')
        return;
    end

    root = prev_x(2); 
end