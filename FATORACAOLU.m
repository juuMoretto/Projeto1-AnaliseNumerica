#percorre todas linhas/colunas
for i=1:n 
  #checa se linha e colunas nao sao nulas
  if(ENVcol_sup(i) != ENVcol_sup(i+1))
    if(ENVlin_inf(i) != ENVlin_inf(i+1))
      #atualiza os indices das colunas e linhas para estarem no elemento certo para fazer os calculos do U como no algoritmo do item 3.
      soma = 0;
      dif = ENVlin_sup(ENVcol_sup(i)) - ENVcol_inf(ENVlin_inf(i));
      if(dif < 0)
        indice_sup = ENVcol_sup(i)- dif;
        indice_inf = ENVlin_inf(i);
        inicio =  ENVcol_inf(ENVlin_inf(i));
      else
       indice_inf = ENVlin_inf(i)+dif;
        indice_sup = ENVcol_sup(i);
        inicio = ENVlin_sup(ENVcol_sup(i));
      endif
      #Calcula os U que pertencem ao envelope de A sobrescrevendo na porcao superior de A e diagonal
      while (inicio < i)
        ENVsup(indice_sup) = (ENVsup(indice_sup)-soma*ENVlin_inf(indice_inf));
        soma = soma + ENVsup(indice_sup);
        inicio = inicio+1;
        indice_sup = indice_sup + 1;
        indice_inf = indice_inf + 1;
      endwhile
     DIAG(i) = (DIAG(i) - soma);
      
      # Atualiza os indices para calculo dos elementos de L
      soma = 0;
      j = i+1;
      dif = ENVcol_inf(ENVlin_inf(i)) - j;
      if(dif > 0)
        j = ENVcol_inf(ENVlin_inf(i));
      endif
      
      dif = ENVlin_sup(ENVcol_sup(i)) - ENVcol_inf(ENVlin_inf(i));
      if(dif < 0)
        indice_sup = ENVcol_sup(i)- dif;
        indice_inf = ENVlin_inf(i);
        inicio =  ENVcol_inf(ENVlin_inf(i));
      else
       indice_inf = ENVlin_inf(i)+dif;
        indice_sup = ENVcol_sup(i);
        inicio = ENVlin_sup(ENVcol_sup(i));
      endif
      if (j<inicio)
        j=inicio;
      else
        dif = j - inicio;
        indice_sup = indice_sup + dif;
        indice_inf = indice_inf + dif;
      endif
      #Calcula os L que pertencem ao envelope de A sobrescrevendo na porcao inferior de A e considerando que a diagonal de L tem termos todos de valor 1
      while(j<n)
        ENVinf(indice_inf) = (ENVinf(indice_inf)-soma*ENVcol_sup(indice_sup))/DIAG(j);
        soma = soma + ENVsup(indice_sup);
        j = j+1;
        indice_sup = indice_sup + 1;
        indice_inf = indice_inf + 1;
      endwhile
      
     endif
  endif
endfor
