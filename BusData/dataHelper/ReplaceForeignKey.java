import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class ReplaceForeignKey {

        public static void main(String[] args) throws IOException{
                String tablePrimName = args[0];                                 // Primary Key File
                String KeyName = args[1];                                       // Primary Key
                String tableForeignName = args[2];                              // Foreign Key File
                String tableForeignNameWithNewKey = args[3];                    // New Foreign Key File

                Map<String,Integer> OldNewKeyMap= new HashMap<String,Integer>();        // Mapping From Old Key to New Key

                // Find the column need to replace
                BufferedReader brTablePrim = new BufferedReader(new FileReader(new File(tablePrimName)));
                String tableColumn = brTablePrim.readLine();
                String[] tableColumnArray = tableColumn.split(",");
                int column;
                for (column = 0; column<tableColumnArray.length;column++){
                        if (tableColumnArray[column].equals(KeyName))
                                break;
                }

                // Generate Old to New Key Mapping
                String line;
                int newKey = 1;
                while ((line = brTablePrim.readLine()) != null) {
                        String[] lineArray = line.split(",");
                        if (!OldNewKeyMap.containsKey(lineArray[column]))
                                OldNewKeyMap.put(lineArray[column], newKey++);
                }
                brTablePrim.close();

                // Replace Foreign Key
                BufferedReader brTableForeign = new BufferedReader(new FileReader(new File(tableForeignName)));
                BufferedWriter bwTableForeignWithNewKey = new BufferedWriter(new FileWriter(new File(tableForeignNameWithNewKey)));
                tableColumn = brTableForeign.readLine();
                tableColumnArray = tableColumn.split(",");
                for (column = 0; column<tableColumnArray.length;column++){
                        if (tableColumnArray[column].equals(KeyName))
                                break;
                }
                bwTableForeignWithNewKey.write(tableColumn+"\n");

                String result;
                while ((line = brTableForeign.readLine()) != null) {
                        String[] lineArray = line.split(",");
                        newKey = OldNewKeyMap.get(lineArray[column]);
                        lineArray[column] = Integer.toString(newKey);
                        result = String.join(",", lineArray)+"\n";
                        bwTableForeignWithNewKey.write(result);
                }
                brTableForeign.close();
                bwTableForeignWithNewKey.close();
        }
}

