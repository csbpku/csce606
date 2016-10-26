import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class DeleteColumn {

        public static void main(String[] args) throws IOException{
                String tablePrimName = args[0];                                 // Primary Key File
                String KeyName = args[1];                                       // Primary Key
                String tablePrimNameWithNewKey = args[2];                       // New Primary Key File

                BufferedReader brTablePrim = new BufferedReader(new FileReader(new File(tablePrimName)));
                BufferedWriter bwTablePrim = new BufferedWriter(new FileWriter(new File(tablePrimNameWithNewKey)));

                String tableColumn = brTablePrim.readLine();
                String[] tableColumnArray = tableColumn.split(",");
                int column;
                for (column = 0; column<tableColumnArray.length;column++){
                        if (tableColumnArray[column].equals(KeyName))
                                break;
                }
                
                List<String> tableColumnList = new ArrayList<String>(Arrays.asList(tableColumnArray));
                tableColumnList.remove(column);
                String[] newTableColumnArray = new String[tableColumnList.size()];
                newTableColumnArray =  tableColumnList.toArray(newTableColumnArray);
                String tableColumnResult = String.join(",", newTableColumnArray)+"\n";
                bwTablePrim.write(tableColumnResult);

                String line;
                String result;
                while ((line = brTablePrim.readLine()) != null) {
                        String[] lineArray = line.split(",");
                        List<String> list = new ArrayList<String>(Arrays.asList(lineArray));
                        list.remove(column);
                        String[] newLineArray = new String[list.size()];
                        newLineArray =  list.toArray(newLineArray);
                        result = String.join(",", newLineArray)+"\n";
                        bwTablePrim.write(result);
                }
                brTablePrim.close();
                bwTablePrim.close();
        }
}

