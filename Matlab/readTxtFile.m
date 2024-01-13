function matrix = readTxtFile(fileName)
   
    % Lee una matriz 3xN desde un archivo .txt
    
    % Abre el archivo para lectura
    fileID = fopen(fileName, 'r');

    if fileID == -1
        error('No se puede abrir el archivo para lectura.');
    else
        % Lee la matriz desde el archivo
        matrix = fscanf(fileID, '%f', [3, Inf]);
        
        % Cierra el archivo
        fclose(fileID);
        
        fprintf('Matriz leída desde %s.\n', fileName);
    end
end