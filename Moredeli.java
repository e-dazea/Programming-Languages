import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*; 
import java.io.File;

class costPriority implements Comparator<SpaceMap> {
	@Override
    public int compare(SpaceMap a1, SpaceMap a2) {
        return a1.getCost() < a2.getCost() ? -1 : a1.getCost() == a2.getCost() ? 0 : 1;
    }
}

class SpaceMap {

    int i,j,cost;
    char thesi;
    public SpaceMap() {}
    
    public SpaceMap(int line, int column) {
        i=-1;
        j=-1;
        cost=-1;
        thesi = ' ';
    }
    
    int getI() { return i; }
    int getJ() { return j; }
    int getCost() { return cost; }
    char getThesi() { return thesi; }
    
    void change (int newI, int newJ, int newCost, char newThesi) {
        i=newI;
        j=newJ;
        cost=newCost;
        thesi=newThesi;
    }

    void changeCost (int newCost) { cost = newCost; }
    }


public class Moredeli {

    public static void main(String[] args) {
        //declarations 
        int lines=0, startI=0, startJ=0, columns=0, i=0, j=0, cost=0, iPrev=0, jPrev=0, temporary=0, costPrev=0, newCost=0;
        char t, tPrev;
        // read from file
        File inFile = null;
        if (0 < args.length) {
            inFile = new File(args[0]); }
        else {
            System.err.println("Invalid arguments count:" + args.length);
            System.exit(1);
        } 
        BufferedReader br = null;
        SpaceMap[][] xartis = new SpaceMap[1000][1000];
        try {
            br = new BufferedReader(new FileReader(inFile));
            String sCurrentLine;
            sCurrentLine = br.readLine(); //does not save the \n
            columns = sCurrentLine.length();
            while (sCurrentLine != null) {
                for (i=0; i<columns; i++){
                    xartis[lines][i] = new SpaceMap(lines,i);
    					xartis[lines][i].change(lines, i, 0, sCurrentLine.charAt(i));
                    if ( sCurrentLine.charAt(i) == 'S' ){
                        startI = lines;
                        startJ = i;
                    }
                }
                lines++;
                sCurrentLine = br.readLine();
            }
        } 
        catch (IOException e) { e.printStackTrace(); } 
        finally {
            try {
                if (br != null)
                    br.close();
            } 
            catch (IOException ex) { ex.printStackTrace();}
        }
        costPriority strategy = new costPriority();
        PriorityQueue<SpaceMap> q = new PriorityQueue<SpaceMap>(11, strategy);
        q.add(xartis[startI][startJ]);
        SpaceMap[][] prev = new SpaceMap[lines][columns];
        for (i=0;i<lines;i++) {
            for (j=0;j<columns;j++) {
                prev[i][j] = new SpaceMap();
            }
        }
        for (i=0;i<lines;i++) {
            for (j=0;j<columns;j++) {
                prev[i][j].change(-1,-1,-1,' ');
            }
        }
        prev[startI][startJ].change(-1,-1,0,' ');
        SpaceMap temp = new SpaceMap();
        while (!q.isEmpty()) {
            temp = (SpaceMap) q.remove();
            t = temp.getThesi();
            i = temp.getI();
            j = temp.getJ();
            cost = temp.getCost();
            if (t == 'E') {
                System.out.print(cost);
                System.out.print(' ');
                tPrev = prev[i][j].getThesi();
                iPrev = prev[i][j].getI();
                jPrev = prev[i][j].getJ();
                Stack s = new Stack();
                while ( tPrev != ' ') {
                    s.push(tPrev);
                    tPrev = prev[iPrev][jPrev].getThesi();
                    temporary = iPrev;
                    iPrev = prev[iPrev][jPrev].getI();
                    jPrev = prev[temporary][jPrev].getJ();
                }
                while ( !s.empty() ) {
                    t = (char) s.pop();
                    System.out.print(t);
                }
		break;
            }
            //check left neighbor
            if (j != 0) {
                t = xartis[i][j-1].getThesi();
                if (t != 'X') {
                    
                    costPrev = prev[i][j-1].getCost();
                    if ( ( (cost+2) < costPrev) || (costPrev == -1) ) {
                        prev[i][j-1].change(i,j,cost+2,'L');
                        xartis[i][j-1].changeCost(cost+2);
                        q.add(xartis[i][j-1]);
                    }
                }
            }
            //check right neighbor
            if (j != (columns-1)) {
                t = xartis[i][j+1].getThesi();
                if (t != 'X') {
                    costPrev = prev[i][j+1].getCost();
                    newCost = cost + 1;
                    if ( ( (newCost) < costPrev) || (costPrev == -1) ) {
                        prev[i][j+1].change(i,j,newCost,'R');
                        xartis[i][j+1].changeCost(newCost);
                        q.add(xartis[i][j+1]);
                    }
                }
            }
            //check upper neighbor
            if (i != 0) {
                t = xartis[i-1][j].getThesi();
                if (t != 'X') {
                    costPrev = prev[i-1][j].getCost();
                    if ( ( (cost+3) < costPrev) || (costPrev == -1) ) {
                        prev[i-1][j].change(i,j,cost+3,'U');
                        xartis[i-1][j].changeCost(cost+3);
                        q.add(xartis[i-1][j]);
                    }
                }
            }
            //check lower neighbor
            if (i != (lines-1)) {
                t = xartis[i+1][j].getThesi();
                if (t != 'X') {
                    costPrev = prev[i+1][j].getCost();
                    if ( ( (cost+1) < costPrev) || (costPrev == -1) ) {
                        prev[i+1][j].change(i,j,cost+1,'D');
                        xartis[i+1][j].changeCost(cost+1);
                        q.add(xartis[i+1][j]);
                    }
                }
            }
        }
    }
}






















