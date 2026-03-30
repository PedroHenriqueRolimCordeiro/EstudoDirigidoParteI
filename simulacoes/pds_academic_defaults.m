function pds_academic_defaults()
% Configuracao visual padrao para figuras com estilo academico.

  close all;

  rootHandle = groot;

  pds_try_set(rootHandle, 'defaultfigurecolor', [1 1 1]);
  pds_try_set(rootHandle, 'defaultfigureposition', [100 100 860 420]);

  pds_try_set(rootHandle, 'defaultaxesfontname', 'Times New Roman');
  pds_try_set(rootHandle, 'defaultaxesfontsize', 11);
  pds_try_set(rootHandle, 'defaultaxeslinewidth', 1.0);
  pds_try_set(rootHandle, 'defaultaxesbox', 'off');
  pds_try_set(rootHandle, 'defaultaxeslayer', 'top');
  pds_try_set(rootHandle, 'defaultaxesfontweight', 'normal');
  pds_try_set(rootHandle, 'defaultaxeslabelfontsizemultiplier', 1.0);
  pds_try_set(rootHandle, 'defaultaxestitlefontsizemultiplier', 1.08);
  pds_try_set(rootHandle, 'defaultaxestitlefontweight', 'bold');
  pds_try_set(rootHandle, 'defaultaxestickdir', 'out');

  pds_try_set(rootHandle, 'defaultaxesxgrid', 'on');
  pds_try_set(rootHandle, 'defaultaxesygrid', 'on');
  pds_try_set(rootHandle, 'defaultaxesxminorgrid', 'off');
  pds_try_set(rootHandle, 'defaultaxesyminorgrid', 'off');
  pds_try_set(rootHandle, 'defaultaxesxminortick', 'off');
  pds_try_set(rootHandle, 'defaultaxesyminortick', 'off');
  pds_try_set(rootHandle, 'defaultaxesgridalpha', 0.18);

  pds_try_set(rootHandle, 'defaultlinelinewidth', 1.4);
  pds_try_set(rootHandle, 'defaulttextfontname', 'Times New Roman');
  pds_try_set(rootHandle, 'defaulttextfontsize', 11);
  pds_try_set(rootHandle, 'defaulttextinterpreter', 'tex');
  pds_try_set(rootHandle, 'defaultlegendinterpreter', 'tex');
  pds_try_set(rootHandle, 'defaultaxesticklabelinterpreter', 'tex');
  pds_try_set(rootHandle, 'defaultlegendfontsize', 10);
  pds_try_set(rootHandle, 'defaultlegendbox', 'off');
end

function pds_try_set(handle, propertyName, value)
  try
    set(handle, propertyName, value);
  catch
  end
end
