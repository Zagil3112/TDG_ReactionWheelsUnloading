function saveVariable(matrix,fileName)
   
    % Guarda una matriz 3xN en un archivo .txt
    
    % Abre el archivo para escritura
    fileID = fopen(fileName, 'w');

    if fileID == -1
        error('No se puede abrir el archivo para escritura.');
    else
        % Escribe la matriz en el archivo
        fprintf(fileID, '%.20f %.20f %.20f\n', matrix);
        
        % Cierra el archivo
        fclose(fileID);
        
        fprintf('Matriz guardada en %s.\n', fileName);
    end
end
