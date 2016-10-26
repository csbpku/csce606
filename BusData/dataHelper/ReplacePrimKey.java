import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ReplacePrimKey {

        public static void main(String[] args) throws IOException{
                String tablePrimName = args[0];                                 // Primary Key File
                String KeyName = args[1];                                       // Primary Key
                String tablePrimNameWithNewKey = args[2];                       // New Primary Key File

                Map<String,Integer> OldNewKeyMap= new HashMap<String,Integer>();        // Mapping From Old Key To New Key

                BufferedReader brTablePrim = new BufferedReader(new FileReader(new File(tablePrimName)));
                BufferedWriter bwTablePrim = new BufferedWriter(new FileWriter(new File(tablePrimNameWithNewKey)));

                String tableColumn = brTablePrim.readLine();
                String[] tableColumnArray = tableColumn.split(",");
                int column;
                for (column = 0; column<tableColumnArray.length;column++){
                        if (tableColumnArray[column].equals(KeyName))
                                break;
                }
                
                bwTablePrim.write(tableColumn+"\n");

                String line;
                String result;
                int newKey = 1;
                while ((line = brTablePrim.readLine()) != null) {
                        String[] lineArray = line.split(",");
                        if (!OldNewKeyMap.containsKey(lineArray[column])){
                                OldNewKeyMap.put(lineArray[column], newKey++);
                        }
                        lineArray[column] = Integer.toString(OldNewKeyMap.get(lineArray[column]));
                        result = String.join(",", lineArray)+"\n";
                        bwTablePrim.write(result);
                }
                brTablePrim.close();
                bwTablePrim.close();
        }
}
